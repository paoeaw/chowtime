class MealPlansController < ApplicationController
  include MealPlansHelper

  def index
    @meal_plans = policy_scope(MealPlan).order(created_at: :desc)
  end

  def show
    @meal_plan = MealPlan.find(params[:id])
    authorize @meal_plan
    @aisles = []
    @meal_plan.doses.each do |dose|
      @aisles << dose.ingredient.aisle.match(/^([^;]+)/)[0]
      @aisles = @aisles.uniq
    end
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
      # recipes = obtain_recipes(params[:meal_params][:calories], params[:meal_params][:diet_type], params[:meal_params][:exclusions])
      calories = params[:meal_params][:calories]
      diet_type = params[:meal_params][:diet_type]
      exclusions = params[:meal_params][:exclusions]
      MealPlanCreationJob.perform_later(calories, diet_type, exclusions, @meal_plan.id)
      redirect_to meal_plan_path(@meal_plan)
    else
      render :new
    end
    # create_meals(recipes, @meal_plan)
    # recipe_ids = obtain_recipe_ids(recipes)
    # ingredients_data = collect_ingredients_data(recipe_ids)
    # create_doses(ingredients_data, @meal_plan)
  end
end
