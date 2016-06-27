class User < ActiveRecord::Base
  has_many :product_orders, as: :customer, dependent: :destroy
  has_many :products, through: :product_orders

  has_many :product_carts, dependent: :destroy
  has_many :carts, through: :product_carts, source: :product

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:admin, :editor, :guest]
end
