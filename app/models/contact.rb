class Contact < ActiveRecord::Base
  validates :address, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}
  validates :phone_number, presence: true
  validates :content, presence: true

  def safe_content
    content.html_safe
  end
end
