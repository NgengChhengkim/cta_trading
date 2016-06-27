class Product < ActiveRecord::Base
  belongs_to :category
  has_many :product_orders, dependent: :destroy
  has_many :product_carts, dependent: :destroy

  delegate :name, to: :category, prefix: true, allow_nil: true

  def discount_price
    retail_sale_price - (retail_sale_price * discount)/100
  end
end
