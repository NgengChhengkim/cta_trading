class Category < ActiveRecord::Base
  has_many :products

  validates :name, presence: true, uniqueness: {case_sensitive: false}

  scope :find_categories, -> ids{where id: ids}

  def has_data?
    products.any?
  end
end
