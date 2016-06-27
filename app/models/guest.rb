class Guest < ActiveRecord::Base
  has_many :product_orders, as: :customer, dependent: :destroy
  has_many :products, through: :product_orders
end
