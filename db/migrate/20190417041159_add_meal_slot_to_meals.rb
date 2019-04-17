class AddMealSlotToMeals < ActiveRecord::Migration[5.2]
  def change
    add_column :meals, :meal_type, :string
  end
end
