class ProductOrdersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, only: [:new, :create]

  def new
    redirect_to product_carts_path
  end

  def create
    @success = ActiveRecord::Base.transaction do
      begin
        create_product_order
        true
      rescue
        raise ActiveRecord::Rollback
        false
      end
    end
    if @success
      load_product_order
      render "shared/orders"
    else
      flash[:danger] = t "cart.flashes.cannot_order"
      redirect_to product_carts_path
    end
  end

  private
  def create_product_order
    @order_code = ProductOrder.set_order_code
    product_carts = current_user.product_carts
    product_carts.each do |product_cart|
      current_user.product_orders.create! order_code: @order_code,
        product_id: product_cart.product_id, quantity: product_cart.quantity
    end
    product_carts.destroy_all
  end

  def load_product_order
    @product_orders = ProductOrder.select_by_order_code @order_code
    @user = current_user
  end
end
