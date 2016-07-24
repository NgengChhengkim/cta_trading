class Invoice < ActiveRecord::Base
  belongs_to :customer, polymorphic: true

  has_many :product_invoices, dependent: :destroy
  has_many :products, through: :product_invoices

  scope :find_invoices, -> ids{where id: ids}
  scope :unseen_invoices, ->{where(seen: false).order created_at: :desc}

  def name
    "#{I18n.t("invoices.name")}#{id}"
  end
end
