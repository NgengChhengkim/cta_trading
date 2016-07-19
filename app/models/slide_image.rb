class SlideImage < ActiveRecord::Base
  mount_uploader :picture, SlideUploader

  scope :find_slide_images, -> ids{where id: ids}

  validates :picture, presence: true
end
