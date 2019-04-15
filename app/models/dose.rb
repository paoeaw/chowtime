class Dose < ApplicationRecord
  belongs_to :meal_plan
  belongs_to :ingredient
  belongs_to :meal
  validates :value, presence: true
  validates :unit, presence: true

  def aisle
    self.ingredient.aisle
  end
end
