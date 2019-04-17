class AddCookedToMeals < ActiveRecord::Migration[5.2]
  def change
    add_column :meals, :cooked, :boolean, null: false, default: false
  end
end
