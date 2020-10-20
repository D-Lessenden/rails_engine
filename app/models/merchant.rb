require 'activerecord-import'

class Merchant < ApplicationRecord
  validates :name, presence: true, length: { allow_blank: false }

  has_many :items
  has_many :invoices

  def self.import_merchants
    merchants = []
    CSV.foreach('db/csv_data/merchants.csv', headers: true) do |row|
      merchants << row.to_h
    end
    Merchant.import(merchants)
  end
end
