class Product < ActiveRecord::Base
  belongs_to :brand
  belongs_to :category

  has_many :product_invoices, dependent: :destroy
  has_many :invoices, through: :product_invoices
  has_many :product_carts, dependent: :destroy

  delegate :name, to: :category, prefix: true, allow_nil: true
  delegate :name, to: :brand, prefix: true, allow_nil: true

  scope :select_products, ->{includes(:category).order created_at: :DESC}

  def is_discount?
    discount.to_f > 0
  end
end
