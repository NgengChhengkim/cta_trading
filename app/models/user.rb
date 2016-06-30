class User < ActiveRecord::Base
  has_many :product_orders, as: :customer, dependent: :destroy
  has_many :products, through: :product_orders

  has_many :product_carts, dependent: :destroy
  has_many :carts, through: :product_carts, source: :product

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: {minimum: 4}
  validates :phone_number, presence: true

  enum role: [:admin, :editor, :guest]
end
