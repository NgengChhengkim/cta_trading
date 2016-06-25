class ProductCartsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_product_cart, only: [:create]

  def index
    if user_signed_in?
      @product_carts = current_user.product_carts.includes product: :category
    else
      product_cart_cookie = cookies[:product_cart]
      @products = []
      if product_cart_cookie
        @product_object = JSON.parse cookies[:product_cart]
        @product_cart = @product_object.map {|product| product["id"]}
        @products = Product.where(id: @product_cart).includes :category
      end
    end
  end

  def create
    unless @product_cart.new_record?
      @product_cart.quantity = @product_cart.quantity + 1
    end
    @product_cart.save
    load_quantity
    respond_to do |format|
      format.js
    end
  end

  def update
    @product_cart = @product_cart.update_attributes product_cart_params
    load_quantity
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @product_cart.destroy
    load_quantity
    respond_to do |format|
      format.js
    end
  end

  private
  def product_cart_params
    params.require(:product_cart).permit :user_id, :product_id, :quantity
  end

  def set_product_cart
    @product_cart = ProductCart.find_or_initialize_by product_cart_params
    @product_cart.user_id = current_user.id
  end

  def load_quantity
    @product_cart_number = current_user.product_carts.sum :quantity
  end
end
