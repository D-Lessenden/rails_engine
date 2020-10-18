class AddColumnsToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :unit_price, :integer
    add_reference :items, :merchant, foreign_key: true
  end
end
