require 'activerecord-import'

class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  has_many :invoices
  def self.import_customers
    customers = []
    CSV.foreach('db/csv_data/customers.csv', headers: true) do |row|
      customers << row.to_h
    end
    Customer.import(customers)
  end
end
