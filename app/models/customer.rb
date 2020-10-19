require 'activerecord-import'

class Customer < ApplicationRecord
  def self.import_customers
    customers = []
    CSV.foreach('db/csv_data/customers.csv', headers: true) do |row|
      customers << row.to_h
    end
    Customer.import(customers)
  end
end
