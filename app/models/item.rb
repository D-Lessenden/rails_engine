require 'csv'
require 'activerecord-import'

class Item < ApplicationRecord
  def self.import_items
    items = []
    CSV.foreach('db/csv_data/items.csv', headers: true) do |row|
      items << row.to_h
    end
    Item.import(items)
  end
end
