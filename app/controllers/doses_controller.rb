class DosesController < ApplicationController
  def index
    @doses = policy_scope(Dose).order(created_at: :desc)
    authorize @doses
  end
end
