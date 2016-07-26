class Promotion < ActiveRecord::Base
  mount_uploader :picture, PromotionUploader

  validates :title, presence: true
  validates :content, presence: true
  validates :picture, presence: true

  scope :find_promotions, -> ids{where id: ids}

  def safe_content
    content.html_safe if content
  end
end
