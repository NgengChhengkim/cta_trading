class Guest < ActiveRecord::Base
  has_many :invoices, as: :customer, dependent: :destroy

  validates :name, presence: true, length: {minimum: 4}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}
  validates :phone_number, presence: true

  before_save {self.email = email.downcase}
end
