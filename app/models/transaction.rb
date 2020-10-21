class Transaction < ApplicationRecord
  validates :credit_card_number, presence: true
  validates :result, presence: true

  belongs_to :invoice
  
  def self.import_transactions
    transactions = []
    CSV.foreach('db/csv_data/transactions.csv', headers: true) do |row|
      transactions << row.to_h
    end
    Transaction.import(transactions)
  end
end
