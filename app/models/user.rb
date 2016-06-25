class User < ActiveRecord::Base
  has_many :product_carts, as: :customer, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:admin, :editor, :guest]
end
