class MealPlansController < ApplicationController
  def index
    @meal_plans = policy_scope(MealPlan).order(created_at: :desc)
  end

  def show
    @meal_plan = MealPlan.find(params[:id])
    authorize @meal_plan
  end

  def new
    @meal_plan = MealPlan.new
    authorize @meal_plan
  end

  def create
    @meal_plan = MealPlan.new
    authorize @meal_plan
    @meal_plan.user = current_user
    @meal_plan.save
    recipes = obtain_recipes(2000, "", "")
    create_meals(recipes, @meal_plan)
    recipe_ids = obtain_recipe_ids(recipes)
    ingredients_data = collect_ingredients_data(recipe_ids)
    create_doses(ingredients_data, @meal_plan)
    redirect_to meal_plan_path(@meal_plan)
  end

  private

  # returns an array of recipe value hashes from spoonacular
  def obtain_recipes(calories, diet_type, excluded_ingredients)
    recipes = []
    conn = Faraday.new(url: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/mealplans/generate?timeFrame=week&targetCalories=#{calories}&diet=#{diet_type}&exclude=#{excluded_ingredients}")
    conn.headers["X-RapidAPI-Host"] = "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
    conn.headers["X-RapidAPI-Key"] = ENV['SPOONACULAR_API_KEY']
    response = conn.get
    response_data = JSON.parse(response.body)
    response_data['items'].each do |item|
      recipe_hash = JSON.parse(item['value'])
      recipes << recipe_hash
    end
    recipes
  end

  def create_meals(recipes, meal_plan)
    recipes.each do |recipe|
      meal = Meal.new(title: recipe['title'], meal_id: recipe['id'], image_url: 'default-food.jpg')
      meal.meal_plan = meal_plan
      meal.save
    end
  end

  # parses recipe value hashes to extract the ids. we'll use these to search for ingredients
  def obtain_recipe_ids(recipes)
    recipe_ids = []
    recipes.each do |recipe|
      recipe_ids << recipe['id']
    end
    recipe_ids
  end

  # returns a hash of ingredient names/quantities from Spoonacular
  # requires an array of recipe ids
  def collect_ingredients_data(recipe_ids)
    ingredients = {}
    recipe_ids.each do |id|
      conn = Faraday.new(url: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/#{id}/ingredientWidget.json")
      conn.headers["X-RapidAPI-Host"] = "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
      conn.headers["X-RapidAPI-Key"] = ENV['SPOONACULAR_API_KEY']
      response = conn.get
      response_data = JSON.parse(response.body)
      response_data['ingredients'].each do |ingredient|
        ingredients[ingredient['name']] = ingredient['amount']
      end
    end
    ingredients
  end

  def create_doses(ingredients_data, meal_plan)
    ingredients_data.each do |key, value|
      ingredient = Ingredient.new(name: key)
      ingredient.save
      dose = Dose.new(value: value['metric']['value'], unit: value['metric']['unit'])
      dose.ingredient = ingredient
      dose.meal_plan = meal_plan
      dose.save
    end
  end
end
