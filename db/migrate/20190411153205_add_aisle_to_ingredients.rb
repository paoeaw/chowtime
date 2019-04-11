class AddAisleToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :aisle, :string
  end
end
