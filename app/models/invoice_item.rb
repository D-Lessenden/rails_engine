class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true
  validates :unit_price, presence: true

  belongs_to :item
  belongs_to :invoice

  def self.convert_price(price)
    (price.to_i * 0.01).round(2)
  end
end
