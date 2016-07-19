class Admin::ProductsController < ApplicationController
  load_and_authorize_resource
  before_action :load_data, only: [:new, :create, :edit, :update]

  def index
    @products = Product.order(created_at: :desc).paginate page: params[:page],
      per_page: Settings.paginate.per_page_10
  end

  def show
  end

  def new
  end

  def create
    if @product.save
      flash[:success] = flash_message "created"
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = flash_message "updated"
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def destroy
    ids = params[:product][:id] if params[:product].present?
    products = Product.find_products ids

    if products.destroy_all
      flash[:success] = flash_message "deleted"
    else
      flash[:error] = flash_message "not_deleted"
    end
    redirect_to admin_products_path
  end

  private
  def product_params
    params.require(:product).permit :code, :name, :category_id, :brand_id,
      :retail_sale_price, :discount, :cover_image, :description,
      images_attributes: [:id, :name, :_destroy]
  end

  def load_data
    @categories = Category.order(:name).map {|category| [category.name, category.id]}
    @brands = Brand.order(:name).map {|brand| [brand.name, brand.id]}
  end
end
