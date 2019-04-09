class DosesController < ApplicationController
  def index
    @doses = Dose.where(meal_plan_id: params[:meal_plan_id].to_i)
    authorize @doses
  end
end
