require 'activerecord-import'

class Invoice < ApplicationRecord
  validates :status, presence: true

   belongs_to :customer
   belongs_to :merchant
   has_many :transactions
   has_many :invoice_items
   has_many :items, through: :invoice_items

  scope :successful, -> { where(status: "shipped") }
  #can change to shipped

  def self.import_invoices
    invoices = []
    CSV.foreach('db/csv_data/invoices.csv', headers: true) do |row|
      invoices << row.to_h
    end
    Invoice.import(invoices)
  end
end
