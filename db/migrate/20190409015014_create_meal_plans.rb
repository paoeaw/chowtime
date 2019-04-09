class CreateMealPlans < ActiveRecord::Migration[5.2]
  def change
    create_table :meal_plans do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
