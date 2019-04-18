class MealsController < ApplicationController
  def show
    @meal = Meal.find(params[:id])
    authorize @meal
  end

  def update
    @meal = Meal.find(params[:id])
    authorize @meal

    @meal.update(cooked: true)

    redirect_to meal_plan_meal_path(@meal.meal_plan, @meal)
  end
end
