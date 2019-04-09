class DosesController < ApplicationController
  def index
    @doses = policy_scope(Dose).where(meal_plan_id: params[:meal_plan_id]).order(created_at: :desc)
  end
end
