class Product < ActiveRecord::Base
  mount_uploader :cover_image, ProductImageUploader

  belongs_to :brand
  belongs_to :category

  has_many :product_invoices, dependent: :destroy
  has_many :invoices, through: :product_invoices
  has_many :product_carts, dependent: :destroy
  has_many :images, dependent: :destroy

  delegate :name, to: :category, prefix: true, allow_nil: true
  delegate :name, to: :brand, prefix: true, allow_nil: true

  validates :code, presence: true, uniqueness: {case_sensitive: false}
  validates :name, presence: true
  validates :retail_sale_price, presence: true, numericality: {greater_than_or_equal: 0}
  validates :discount, numericality: {greater_than_or_equal: 0}
  validates :category_id, presence: true
  validates :brand_id, presence: true
  validates :cover_image, presence: true

  scope :select_products, ->{includes(:category).order created_at: :DESC}
  scope :find_products, -> ids{where id: ids}

  accepts_nested_attributes_for :images,
    reject_if: proc {|attributes| attributes[:name].blank?}, allow_destroy: true

  before_save :calculate_discount_price

  def is_discount?
    discount.to_f > 0
  end

  def safe_description
    description.html_safe if description
  end

  def safe_usage
    usage.html_safe if usage
  end

  def has_data?
    invoices.present? || product_carts.present?
  end

  def calculate_discount_price
    self.discount_price = retail_sale_price - (retail_sale_price * discount) / 100
  end
end
