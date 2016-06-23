class Country < ActiveRecord::Base
  has_many :suppliers, dependent: :destroy
end
