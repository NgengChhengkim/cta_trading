class Admin::InvoicesController < ApplicationController
  load_and_authorize_resource

  def index
    @q = Invoice.ransack params[:q]
    @invoices = @q.result.order(seen: :asc, created_at: :desc)
      .paginate page: params[:page], per_page: Settings.paginate.per_page_10
  end

  def show
    @invoice.update_attribute :seen, true unless @invoice.seen?

    @product_invoices = @invoice.product_invoices.select_product_invoices
      .paginate page: params[:page], per_page: Settings.paginate.per_page
    @user = @invoice.customer
  end

  def update
    mark_seen = @invoice.seen? ? false : true
    @invoice.update_attribute :seen, mark_seen

    respond_to do |format|
      format.js
    end
  end

  def destroy
    ids = params[:invoice][:id] if params[:invoice].present?
    invoices = Invoice.find_invoices ids

    if invoices.destroy_all
      flash[:success] = flash_message "deleted"
    else
      flash[:error] = flash_message "not_deleted"
    end
    redirect_to admin_invoices_path
  end
end
