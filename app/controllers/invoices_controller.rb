class InvoicesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, only: :index

  def index
    @invoices = current_user.invoices
      .paginate(page: params[:page], per_page: Settings.paginate.per_page)
      .order created_at: :desc

    @total_price = ProductInvoice.find_by_user(current_user.id).total_price
  end
end
