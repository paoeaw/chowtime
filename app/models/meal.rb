class Meal < ApplicationRecord
  belongs_to :meal_plan
  validates :title, presence: true
  validates :meal_id, presence: true, uniqueness: true
  validates :image_url, presence: true
end
