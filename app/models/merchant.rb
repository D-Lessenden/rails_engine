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
    if attribute == "created_at" || attribute == "updated_at"
      Merchant.where("to_char(#{attribute}, 'yyyy-mm-dd hh:mm:ss') ILIKE ?", "%#{value}%")
    else
      Merchant.where("#{attribute} ILIKE ?", "%#{value}%")
    end
  end

  def self.most_revenue(quantity)
    Merchant.select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Invoice.successful)
    .merge(Transaction.successful)
    .group(:id).order(revenue: :desc)
    .limit(quantity)
  end

  def self.most_items(quantity)
    Merchant.select("merchants.*, sum(invoice_items.quantity) as most_items")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .merge(Invoice.successful)
    .group(:id).order(most_items: :desc)
    .limit(quantity)
  end

  def self.total_revenue(merchant)
    revenue = Merchant.joins(invoices: [:transactions, :invoice_items])
    .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .where("merchant_id='#{merchant.id}' AND invoices.status='shipped' AND transactions.result='success'")
    .group("merchants.id")
    Revenue.new(revenue)
  end
end
