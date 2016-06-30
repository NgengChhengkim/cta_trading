class Guest < ActiveRecord::Base
  has_many :product_orders, as: :customer, dependent: :destroy
  has_many :products, through: :product_orders

  validates :name, presence: true, length: {minimum: 4}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}
  validates :phone_number, presence: true

  before_save {self.email = email.downcase}
end
