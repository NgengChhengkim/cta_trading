class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  layout :layout_by_resource
  include ApplicationHelper

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

    current_user.customer? ? root_path : admin_root_path
  end

  def after_sign_out_path_for resource
    cookies.delete :product_cart
    root_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    if current_user.present? && current_user.editor?
      redirect_to admin_root_path
    elsif
      redirect_to root_path
    end
  end

  protected

  def current_ability
    controller_name_segments = params[:controller].split('/')
    controller_name_segments.pop
    controller_namespace = controller_name_segments.join('/').camelize
    Ability.new(current_user, controller_namespace)
  end

  def layout_by_resource
    if self.class.parent == Admin
      "admin/application"
    else
      "application"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name, :address, :phone_number]
    devise_parameter_sanitizer.permit :account_update, keys: [:name, :address, :phone_number]
  end
end
