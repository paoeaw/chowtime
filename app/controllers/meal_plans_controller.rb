class MealPlansController < ApplicationController
  include MealPlansHelper

  def index
    @meal_plans = policy_scope(MealPlan).order(created_at: :desc)
    @meals_cooked = current_user.cooked_count
  end

  def show
    @meal_plan = MealPlan.find(params[:id])
    authorize @meal_plan
    @aisles = @meal_plan.aisles
    @breakfast_meals = @meal_plan.meals.where(meal_type: 'breakfast')
    @lunch_meals = @meal_plan.meals.where(meal_type: 'lunch')
    @dinner_meals = @meal_plan.meals.where(meal_type: 'dinner')
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
  end

  def update
    @meal_plan = MealPlan.find(params[:id])
    authorize @meal_plan
    update_doses(params['purchased'])

    render :show
  end
end
