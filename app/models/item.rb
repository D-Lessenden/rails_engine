require 'csv'
require 'activerecord-import'

class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

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

  def self.single_finder(attribute, value)
    if attribute == 'unit_price'
      Item.where("to_char(#{attribute}, '000.00') ILIKE ?", "%#{value}%").first
    elsif attribute == "created_at" || attribute == "updated_at"
      Item.where("to_char(#{attribute}, 'yyyy-mm-dd hh:mm:ss') ILIKE ?", "%#{value}%").first
    else
      Item.where("#{attribute} ILIKE ?", "%#{value}%").first
    end
  end

  def self.multiple_finder(attribute, value)
    if attribute == 'unit_price'
      Item.where("to_char(#{attribute}, '000.00') ILIKE ?", "%#{value}%")
    elsif attribute == "created_at" || attribute == "updated_at"
      Item.where("to_char(#{attribute}, 'yyyy-mm-dd hh:mm:ss') ILIKE ?", "%#{value}%")
    else
      Item.where("#{attribute} ILIKE ?", "%#{value}%")
    end
  end
end
