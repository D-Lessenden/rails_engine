require 'activerecord-import'

class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoices

  def self.import_merchants
    merchants = []
    CSV.foreach('db/csv_data/merchants.csv', headers: true) do |row|
      merchants << row.to_h
    end
    Merchant.import(merchants)
  end


  def self.single_finder(attribute, value)
    if attribute == "created_at" || attribute == "updated_at"
      Merchant.where("to_char(#{attribute}, 'yyyy-mm-dd hh:mm:ss') ILIKE ?", "%#{value}%").first
    else
      Merchant.where("#{attribute} ILIKE ?", "%#{value}%").first
    end
  end

  def self.multiple_finder(attribute, value)
    Merchant.where("#{attribute} ILIKE ?", "%#{value}%")
  end
end
