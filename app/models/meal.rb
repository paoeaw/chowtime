class Meal < ApplicationRecord
  belongs_to :meal_plan
  has_many :doses
  validates :title, presence: true
  validates :meal_id, presence: true
  validates :image_url, presence: true

  def has_ingredients_to_buy
    self.doses.where(purchased: false).any?
  end

  def ingredients_to_buy
    self.doses.where(purchased: false)
  end

  def num_ingredients_left
    self.doses.where(purchased: false).count
  end

  def num_ingredients_bought
    self.doses.where(purchased: true).count
  end

  def purchased_ingredients
    self.doses.where(purchased: true)
  end

  def can_make_it?
    !has_ingredients_to_buy
  end
end
