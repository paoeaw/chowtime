class Meal < ApplicationRecord
  belongs_to :meal_plan
  validates :title, presence: true
  validates :meal_id, presence: true
  validates :image_url, presence: true
end
