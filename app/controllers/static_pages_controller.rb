class StaticPagesController < ApplicationController
  def index
    @products = Product.select_products.limit Settings.paginate.hot_product
  end

  def contact
    @contact = Contact.first
  end
end
