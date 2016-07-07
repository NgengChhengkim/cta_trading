class SearchesController < ApplicationController
  def index
    @q = Product.ransack params[:q]
    @products = @q.result.select_products.paginate page: params[:page],
      per_page: Settings.paginate.per_page
    respond_to do |format|
      format.html
      format.js
    end
  end
end
