class ProductOrder < ActiveRecord::Base
  belongs_to :customer, polymorphic: true
  belongs_to :product

  validates :customer_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true, numericality: {greater_than: 0}
end
