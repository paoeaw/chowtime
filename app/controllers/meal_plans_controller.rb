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
end
