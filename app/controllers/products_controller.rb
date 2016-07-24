class ProductsController < ApplicationController
  load_and_authorize_resource

  def show
    @category = @product.category
    @related_products = @category.products.limit Settings.paginate.related_product
    @brands = Brand.all
    @categories = Category.all
    @images = @product.images
  end
end
