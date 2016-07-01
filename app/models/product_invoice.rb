class ProductInvoice < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :product

  delegate :id, :name, :retail_sale_price, :discount_price, :discount,
    to: :product, prefix: true, allow_nil: true
end
