class ProductInvoice < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :product

  delegate :id, :name, :retail_sale_price, :discount_price, :discount,
    to: :product, prefix: true, allow_nil: true

  scope :total_price, ->{joins(:product)
    .sum("product_invoices.quantity * products.discount_price")}

  scope :find_by_user, -> user{joins(:invoice)
    .where("invoices.customer_id = ? and customer_type = 'User'", user)
    .includes product: :category}

  scope :select_product_invoices, ->{includes product: :category}
end
