class CreateMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :meals do |t|
      t.references :meal_plan, foreign_key: true
      t.string :title
      t.string :meal_id
      t.string :image_url

      t.timestamps
    end
  end
end
