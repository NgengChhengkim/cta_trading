class ProductCart < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  delegate :id, :name, :retail_sale_price, to: :product, prefix: true, allow_nil: true
end
