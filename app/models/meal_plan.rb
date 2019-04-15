class MealPlan < ApplicationRecord
  belongs_to :user
  has_many :doses, dependent: :delete_all
  has_many :meals, dependent: :delete_all

  def purchased_ingredients
    purchased_ingredients = []
    self.doses.each do |dose|
      purchased_ingredients << dose if dose.purchased?
    end
    purchased_ingredients
  end
end
