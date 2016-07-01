class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for resource
    product_cart_cookie = cookies[:product_cart]
    if product_cart_cookie
      product_carts = JSON.parse product_cart_cookie

      ActiveRecord::Base.transaction do
        product_carts.each do |product_cart|
          cart = ProductCart.find_or_initialize_by product_id: product_cart["id"],
            user_id: current_user.id
          if cart.new_record?
            cart.quantity = product_cart["quantity"]
          else
            cart.quantity = cart.quantity + product_cart["quantity"]
          end
          cart.save
        end
      end
    end
    cookies.delete :product_cart
    stored_location_for(resource) || root_path
  end

  def after_sign_out_path_for resource
    cookies.delete :product_cart
    root_path
  end
end
