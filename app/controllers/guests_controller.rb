class GuestsController < ApplicationController
  load_and_authorize_resource

  def create
    @success = ActiveRecord::Base.transaction do
      begin
        @guest.save!
        @invoice = @guest.invoices.create!
        create_product_invoice_from_cookies
        true
      rescue
        raise ActiveRecord::Rollback
        false
      end
    end
    if @success
      cookies.delete :product_cart
      load_product_invoice
      SendEmailWorker.perform_async @invoice.id
      render "shared/invoice"
    else
      flash[:danger] = t "cart.flashes.cannot_order"
      redirect_to product_carts_path
    end
  end

  private
  def guest_params
    params.require(:guest).permit :name, :email, :address, :phone_number
  end

  def create_product_invoice_from_cookies
    products = JSON.parse cookies[:product_cart]
    products.each do |product|
      @invoice.product_invoices.create! product_id: product["id"], quantity: product["quantity"]
    end
  end

  def load_product_invoice
    @product_invoices = @invoice.product_invoices.includes product: :category
    @user = @guest
  end
end
