class MealPlan < ApplicationRecord
  belongs_to :user
  has_many :doses, dependent: :delete_all
  has_many :meals, dependent: :delete_all

  def aisles
    aisles = []
    self.doses.each do |dose|
      aisles << dose.aisle
    end
    aisles = aisles.uniq
  end

  #returns an array of cooked meals for a meal plan
  def cooked_meals
    self.meals.where(cooked: true)
  end

  def meals_cooked_percent
    # meals cooked divided by all meal plan meals
    cooked_count = 0
    self.meals.each do |meal|
      cooked_count += 1 if meal.cooked
    end
    (cooked_count.to_f / self.meals.count.to_f * 100).to_i
  end

  def ingredients_bought_percent
    # ingredients purchased divided by all meal plan ingredients
    purchased_count = 0
    self.doses.each do |dose|
      purchased_count += 1 if dose.purchased
    end
    (purchased_count.to_f / self.doses.count.to_f * 100).to_i
  end

  def ingr_by_aisle
    ingr_by_aisle = {}
    self.aisles.each do |aisle|
      ingr_by_aisle[aisle] = Hash.new(0)
      self.doses.each do |dose|
        if dose.ingredient.aisle == aisle
          ingr_by_aisle[aisle][dose.ingredient.name] += dose.value
        end
      end
      self.doses.each do |dose|
        if dose.ingredient.aisle == aisle && ingr_by_aisle[aisle][dose.ingredient.name].class == Float
          ingr_by_aisle[aisle][dose.ingredient.name] = ingr_by_aisle[aisle][dose.ingredient.name].to_i if ingr_by_aisle[aisle][dose.ingredient.name] % 1 == 0
          ingr_by_aisle[aisle][dose.ingredient.name] = [ingr_by_aisle[aisle][dose.ingredient.name].to_s + " #{dose.unit}", dose.id]
        end
      end
    end
    ingr_by_aisle
  end

  def purchased_ingredients
    purchased_ingredients = []
    self.doses.each do |dose|
      purchased_ingredients << dose if dose.purchased?
    end
    purchased_ingredients
  end

  def self.purchased_ratio(hash)
    completed = 0
    total = hash.size
    hash.each do |_ingr_name, dose_info|
      dose = Dose.find(dose_info[1])
      completed += 1 if dose.purchased
    end
    "<span class='completed'>#{completed}</span>/<span class='total'>#{total}</span>"
  end
end
