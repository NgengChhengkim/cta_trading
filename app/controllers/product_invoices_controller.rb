class ProductInvoicesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, only: [:new, :create]

  def new
    redirect_to product_carts_path
  end

  def create
    @success = ActiveRecord::Base.transaction do
      begin
        @invoice = current_user.invoices.create!
        create_product_invoice
        true
      rescue
        raise ActiveRecord::Rollback
        false
      end
    end
    if @success
      load_product_invoice
      render "shared/invoice"
    else
      flash[:danger] = t "cart.flashes.cannot_order"
      redirect_to product_carts_path
    end
  end

  private
  def create_product_invoice
    product_carts = current_user.product_carts
    product_carts.each do |product_cart|
      @invoice.product_invoices.create! product_id: product_cart.product_id,
        quantity: product_cart.quantity
    end
    product_carts.destroy_all
  end

  def load_product_invoice
    @product_invoices = @invoice.product_invoices.includes product: :category
    @user = current_user
  end
end
