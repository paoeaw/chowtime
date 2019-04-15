class Meal < ApplicationRecord
  belongs_to :meal_plan
  has_many :doses
  validates :title, presence: true
  validates :meal_id, presence: true
  validates :image_url, presence: true

  def has_ingredients_to_buy
    self.doses.where(purchased: false).any?
  end
end
