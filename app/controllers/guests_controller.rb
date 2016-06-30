class GuestsController < ApplicationController
  load_and_authorize_resource

  def create
    @success = ActiveRecord::Base.transaction do
      begin
        @guest.save!
        create_product_order_from_cookies
        true
      rescue
        raise ActiveRecord::Rollback
        false
      end
    end
    if @success
      cookies.delete :product_cart
      load_product_order
      render "shared/orders"
    else
      flash[:danger] = t "cart.flashes.cannot_order"
      redirect_to product_carts_path
    end
  end

  private
  def guest_params
    params.require(:guest).permit :name, :email, :address, :phone_number
  end

  def create_product_order_from_cookies
    @order_code = ProductOrder.set_order_code
    products = JSON.parse cookies[:product_cart]
    products.each do |product|
      @guest.product_orders.create! order_code: @order_code, product_id: product["id"],
        quantity: product["quantity"]
    end
  end

  def load_product_order
    @product_orders = ProductOrder.select_by_order_code @order_code
    @user = @guest
  end
end
