class Guest < ActiveRecord::Base
  has_many :product_carts, as: :customer, dependent: :destroy
end
