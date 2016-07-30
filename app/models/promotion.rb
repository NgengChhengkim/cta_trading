class Promotion < ActiveRecord::Base
  mount_uploader :picture, PromotionUploader

  validates :kind, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :picture, presence: true

  scope :find_promotions, -> ids{where id: ids}
  scope :find_kind, -> kind{where kind: kind}
  scope :exept_id, -> id{where.not id: id}

  enum kind: [:promotions, :events, :videos]

  def safe_content
    content.html_safe if content
  end
end
