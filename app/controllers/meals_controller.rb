class MealsController < ApplicationController
  def show
    @meal = Meal.find(params[:id])
    authorize @meal
  end
end
