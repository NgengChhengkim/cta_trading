class StaticPagesController < ApplicationController
  def index
    @products = Product.select_products.limit Settings.paginate.per_page
  end

  def contact
    @contact = Contact.first
  end
end
