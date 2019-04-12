class Meal < ApplicationRecord
  belongs_to :meal_plan
  has_many :doses
  validates :title, presence: true
  validates :meal_id, presence: true
  validates :image_url, presence: true
end
