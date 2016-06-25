class ProductOrder < ActiveRecord::Base
  belongs_to :customer, polymorphic: true
  belongs_to :product
end
