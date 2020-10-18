require 'csv'
require 'activerecord-import'

class Merchant < ApplicationRecord
  def self.import_merchants
    merchants = []
    CSV.foreach('db/csv_data/merchants.csv', headers: true) do |row|
      merchants << row.to_h
    end
    Merchant.import(merchants)
  end
end
