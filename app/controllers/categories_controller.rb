class CategoriesController < ApplicationController
  load_and_authorize_resource

  def show
    @brands = Brand.all
    if params[:brand_id].present?
      @products = Product.find_by_brand_category(params[:brand_id], @category.id)
        .paginate page: params[:page], per_page: Settings.paginate.per_page

      @brand_name = Brand.find(params[:brand_id]).name
    else
      @products = @category.products.select_products
        .paginate page: params[:page], per_page: Settings.paginate.per_page

      @brand_name = t "labels.all_brands"
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
