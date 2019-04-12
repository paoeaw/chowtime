class AddColumnsToDoses < ActiveRecord::Migration[5.2]
  def change
    add_reference :doses, :meal, foreign_key: true
    add_column :doses, :direction, :string
  end
end
