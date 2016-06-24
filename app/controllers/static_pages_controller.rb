class StaticPagesController < ApplicationController
  def cart
    product_cart_cookie = cookies[:product_cart]
    @products = []
    if product_cart_cookie
      @product_cart = JSON.parse cookies[:product_cart]
      @products = Product.where id: @product_cart
    end
  end
end
