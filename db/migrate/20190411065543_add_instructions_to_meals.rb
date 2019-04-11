class AddInstructionsToMeals < ActiveRecord::Migration[5.2]
  def change
    add_column :meals, :directions, :text
  end
end
