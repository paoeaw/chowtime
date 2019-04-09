class DosePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(meal_plan_id: params[:meal_plan_id].to_i)
    end
  end
end
