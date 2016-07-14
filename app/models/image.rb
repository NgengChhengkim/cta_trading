class Image < ActiveRecord::Base
  mount_uploader :name, ProductImageUploader

  belongs_to :product

  validates :name, presence: true
end
