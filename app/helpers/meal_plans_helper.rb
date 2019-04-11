module MealPlansHelper
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
      conn = Faraday.new(url: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/#{recipe['id']}/information")
      conn.headers["X-RapidAPI-Host"] = "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
      conn.headers["X-RapidAPI-Key"] = ENV['SPOONACULAR_API_KEY']
      response = conn.get
      response_data = JSON.parse(response.body)
      meal.image_url = response_data['image']
      meal.directions = response_data['instructions']
      meal.meal_plan = meal_plan
      meal.save
      response_data['extendedIngredients'].each do |ext_ingr|
        unless ext_ingr['amount'].zero?
          ingredient = Ingredient.create(name: ext_ingr['name'], aisle: ext_ingr['aisle'])
          dose = Dose.new(value: ext_ingr['amount'], unit: ext_ingr['unit'], direction: ext_ingr['originalString'])
          dose.ingredient = ingredient
          dose.meal_plan = meal_plan
          dose.meal = meal
          dose.save
        end
      end
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
      ingredient = Ingredient.find_or_create_by(name: key)
      dose = Dose.new(value: value['metric']['value'], unit: value['metric']['unit'])
      dose.ingredient = ingredient
      dose.meal_plan = meal_plan
      dose.save
    end
  end
end
