require 'activerecord-import'

class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant


  def self.import_invoices
    invoices = []
    CSV.foreach('db/csv_data/invoices.csv', headers: true) do |row|
      invoices << row.to_h
    end
    Invoice.import(invoices)
  end
end
