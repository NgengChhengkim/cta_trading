class ProductCart < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true, numericality: {greater_than: 0}

  delegate :id, :name, :retail_sale_price, :discount_price, :discount, to: :product, prefix: true,
    allow_nil: true
end
