class BrandsController < ApplicationController
  load_and_authorize_resource

  def show
    @products = @brand.products.select_products.paginate page: params[:page],
      per_page: Settings.paginate.per_page

    respond_to do |format|
      format.html
      format.js {render "categories/show.js.erb"}
    end
  end
end
