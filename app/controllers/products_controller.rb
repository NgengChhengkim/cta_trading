class ProductsController < ApplicationController
  load_and_authorize_resource

  def show
    @category = @product.category
    @related_products = @category.products.exept_id(@product.id)
      .limit Settings.paginate.related_product
    @brands = Brand.all
    @categories = Category.all
    @images = @product.images
  end
end
