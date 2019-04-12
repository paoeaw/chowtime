class MealPlanCreationJob < ApplicationJob
  queue_as :default
  include MealPlansHelper

  def perform(calories, diet_type, exclusions, meal_plan_id)
    # Do something later
    recipes = obtain_recipes(calories, diet_type, exclusions)
    meal_plan = MealPlan.find(meal_plan_id)
    create_meals(recipes, meal_plan)
    # recipe_ids = obtain_recipe_ids(recipes)
    # ingredients_data = collect_ingredients_data(recipe_ids)
    # create_doses(ingredients_data, meal_plan)
  end
end
