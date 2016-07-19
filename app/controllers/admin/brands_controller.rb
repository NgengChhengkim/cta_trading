class Admin::BrandsController < ApplicationController
  load_and_authorize_resource
  before_action :load_brands, only: [:index, :create, :update, :destroy]
  respond_to :js

  def index
    @brand = Brand.new
  end

  def new
  end

  def create
    if @brand.save
      flash.now[:success] = flash_message "created"
    else
      flash.now[:error] = flash_message "not_created"
    end
  end

  def edit
  end

  def update
    if @brand.update_attributes brand_params
      flash.now[:success] = flash_message "updated"
    else
      flash.now[:error] = flash_message "not_updated"
    end
  end

  def destroy
    ids = params[:brand][:id] if params[:brand].present?
    brands = Brand.find_brands ids

    if brands.destroy_all
      flash.now[:success] = flash_message "deleted"
    else
      flash.now[:error] = flash_message "not_deleted"
    end
  end

  def brand_params
    params.require(:brand).permit :name
  end

  def load_brands
    @brands = Brand.order(:name).paginate page: params[:page],
      per_page: Settings.paginate.per_page_10
  end
end
