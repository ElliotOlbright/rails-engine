class Merchant < ApplicationRecord
  has_many :items
	has_many :invoices

	validates :name, presence: true
  class << self
    def top_earners(quantity)
      joins(invoices: [:invoice_items, :transactions])
        .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
        .merge(Invoice.shipped)
        .merge(Transaction.successful)
        .group(:id)
        .order(revenue: :desc)
        .limit(quantity)
    end

    def top_sellers(quantity)
      joins(invoices: [:invoice_items, :transactions])
        .select('merchants.*, SUM(invoice_items.quantity) AS count')
        .merge(Invoice.shipped)
        .merge(Transaction.successful)
        .order(count: :desc)
        .group(:id)
        .limit(quantity)
    end
  end 
end
