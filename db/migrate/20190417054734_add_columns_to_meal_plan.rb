class AddColumnsToMealPlan < ActiveRecord::Migration[5.2]
  def change
    add_column :meal_plans, :diet_type, :string
    add_column :meal_plans, :exclusions, :string
    add_column :meal_plans, :calories, :string
  end
end
