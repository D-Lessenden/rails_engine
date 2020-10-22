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
    # quantity = quantity.to_i
    # select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue").joins(items: [:invoice_items, :transactions]).where("invoices.status='shipped' AND transactions.result='success'").group("merchants.id").order("revenue DESC").limit(quantity)
    # Merchant.joins(invoices: [:invoice_items, :transactions]).select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue").where("invoices.status='shipped' AND transactions.result='success'").group(:id).order("revenue DESC").limit(quantity)
    Merchant.joins(invoices: [:invoice_items, :transactions]).select("merchants.id, merchants.name, sum(invoice_items.unit_price * invoice_items.quantity) as revenue").where("invoices.status='shipped' AND transactions.result='success'").group("merchants.id").order("revenue DESC").limit(quantity)
  end

  def self.most_items(quantity)
    Merchant.joins(invoices: [:invoice_items, :transactions]).select("merchants.id, sum(invoice_items.quantity) as total_quantity").where("invoices.status='shipped' AND transactions.result='success'").group("merchants.id").order("total_quantity DESC").limit(quantity)
    # Merchant.joins(invoices: [:invoice_items, :transactions]).select("merchants.id, sum(invoice_items.quantity) as total_quantity").where("invoices.status='shipped' AND transactions.result='success'").group("merchants.id").order("total_quantity DESC").limit(3)
    # select("merchants.*, sum(invoice_items.quantity) as total_quantity").joins(invoices: [:invoice_items, :transactions]).merge(Transaction.unscoped.successful).merge(Invoice.unscoped.successful).group(:id).order("total_quantity").limit(quantity)
  end

  def self.total_revenue(merchant)
    # binding.pry
    # Merchant.joins(invoices: [:invoice_items, :transactions]).sum("")
  end
end
