class BrandsController < ApplicationController
  load_and_authorize_resource

  def show
    @categories = Category.all

    if params[:category_id].present?
      @products = Product.find_by_brand_category(@brand.id, params[:category_id])
        .paginate page: params[:page], per_page: Settings.paginate.per_page

      @category_name = Category.find(params[:category_id]).name
    else
      @products = @brand.products.select_products.paginate page: params[:page],
        per_page: Settings.paginate.per_page

      @category_name = t "labels.all_categories"
    end

    respond_to do |format|
      format.html
      format.js {render "categories/show.js.erb"}
    end
  end
end
