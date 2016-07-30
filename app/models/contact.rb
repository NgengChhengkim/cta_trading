class Contact < ActiveRecord::Base
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :content, presence: true

  def safe_content
    content.html_safe
  end
end
