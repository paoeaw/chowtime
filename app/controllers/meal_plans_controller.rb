class MealPlansController < ApplicationController
  def index
    @meal_plans = MealPlan.all
    authorize @meal_plans
  end

  def show
    @meal_plan = MealPlan.find(params[:id])
    authorize @meal_plan
  end

  def new
  end

  def create
  end
end
