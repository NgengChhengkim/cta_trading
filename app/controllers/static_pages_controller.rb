class StaticPagesController < ApplicationController
  def index
    @products = Product.not_discount_products
      .limit(Settings.paginate.hot_product).select_products

    @discount_products = Product.discount_products
      .limit(Settings.paginate.hot_product).select_products
    @slide_images = SlideImage.all
  end

  def discount
    @products = Product.discount_products
      .paginate(page: params[:page], per_page: Settings.paginate.per_page)
      .select_products

    @brands = Brand.all
    @categories = Category.all

    respond_to do |format|
      format.html
      format.js {render "categories/show.js.erb"}
    end
  end

  def contact
    @contact = Contact.first
  end
end
