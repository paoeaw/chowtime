class Dose < ApplicationRecord
  belongs_to :meal_plan
  belongs_to :ingredient
  validates :value, presence: true
  validates :unit, presence: true
end
