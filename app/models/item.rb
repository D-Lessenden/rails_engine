require 'csv'
require 'activerecord-import'

class Item < ApplicationRecord
  def self.import_items
    items = []
    CSV.foreach('db/csv_data/items.csv', headers: true) do |row|
      row["unit_price"] = convert_price(row["unit_price"])
      items << row.to_h
    end
    Item.import(items)
  end

  def self.convert_price(price)
    (price.to_i * 0.01).round(2)
  end
end

# (row["unit_price"].to_i*0.01).round(2)
