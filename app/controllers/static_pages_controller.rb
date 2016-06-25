class StaticPagesController < ApplicationController
  def index
    @products = Product.includes(:category).order(created_at: :DESC).limit 12
    @product_cart = ProductCart.new
  end
end
