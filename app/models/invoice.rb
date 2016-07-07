class Invoice < ActiveRecord::Base
  belongs_to :customer, polymorphic: true

  has_many :product_invoices, dependent: :destroy
  has_many :products, through: :product_invoices

  def name
    "#{I18n.t("invoices.name")}#{id}"
  end
end
