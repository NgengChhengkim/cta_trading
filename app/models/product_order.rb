class ProductOrder < ActiveRecord::Base
  belongs_to :customer, polymorphic: true
  belongs_to :product

  validates :order_code, presence: true
  validates :customer_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true, numericality: {greater_than: 0}

  scope :select_by_order_code, -> order_code{where(order_code: order_code)
    .includes product: :category}

  delegate :id, :name, :retail_sale_price, :discount_price, :discount, to: :product,
    prefix: true, allow_nil: true

  class << self
    def set_order_code
      (last.present? ? last.order_code : 0) + 1
    end
  end
end
