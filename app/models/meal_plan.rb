class MealPlan < ApplicationRecord
  belongs_to :user
  has_many :doses, dependent: :delete_all
  has_many :meals, dependent: :delete_all

end
