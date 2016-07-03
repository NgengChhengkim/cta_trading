class CategoriesController < ApplicationController
  load_and_authorize_resource
  def show
    @products = @category.products.select_products
      .paginate page: params[:page], per_page: Settings.paginate.per_page

    respond_to do |format|
      format.html
      format.js
    end
  end
end
