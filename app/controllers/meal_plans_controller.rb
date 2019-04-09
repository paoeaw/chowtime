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
  end

  private

  # returns an array of recipe ids from Spoonacular
  def obtain_recipe_ids(calories, diet_type, excluded_ingredients)
    recipe_ids = []
    conn = Faraday.new(url: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/mealplans/generate?timeFrame=week&targetCalories=#{calories}&diet=#{diet_type}&exclude=#{excluded_ingredients}")
    conn.headers["X-RapidAPI-Host"] = "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
    conn.headers["X-RapidAPI-Key"] = "ef1d7556fdmshc6fc5f15f724b5ap16c498jsn525dd13a636e"
    response = conn.get
    response_data = JSON.parse(response.body)
    response_data['items'].each do |item|
      recipe_hash = JSON.parse(item['value'])
      recipe_ids << recipe_hash['id']
    end
    recipe_ids
  end

  # returns a hash of ingredient names/quantities from Spoonacular
  # requires an array of recipe ids
  def ingredients(recipe_ids)
    ingredients = {}
    recipe_ids.each do |id|
      conn = Faraday.new(url: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/#{id}/ingredientWidget.json")
      conn.headers["X-RapidAPI-Host"] = "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
      conn.headers["X-RapidAPI-Key"] = "ef1d7556fdmshc6fc5f15f724b5ap16c498jsn525dd13a636e"
      response = conn.get
      response_data = JSON.parse(response.body)
      response_data['ingredients'].each do |ingredient|
        ingredients[ingredient['name']] = ingredient['amount']
      end
    end
    ingredients
  end
end
