class MealPlanPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(record.user == user)
    end
  end
end
