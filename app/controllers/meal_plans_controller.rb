class MealPlansController < ApplicationController
  include MealPlansHelper

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
    if params[:meal_params]
      recipes = obtain_recipes(params[:meal_params][:calories], params[:meal_params][:diet_type], params[:meal_params][:exclusions])
    else
      recipes = obtain_recipes(2000, "", "")
    end
    raise
    create_meals(recipes, @meal_plan)
    recipe_ids = obtain_recipe_ids(recipes)
    ingredients_data = collect_ingredients_data(recipe_ids)
    create_doses(ingredients_data, @meal_plan)
    redirect_to meal_plan_path(@meal_plan)
  end
end
