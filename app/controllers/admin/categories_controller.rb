class Admin::CategoriesController < ApplicationController
  respond_to :js
  load_and_authorize_resource
  before_action :load_categories, only: [:index, :create, :update, :destroy]

  def index
    @category = Category.new
  end

  def new
  end

  def create
    if @category.save
      flash.now[:success] = flash_message "created"
    else
      flash.now[:error] = flash_message "not_created"
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash.now[:success] = flash_message "updated"
    else
      flash.now[:error] = flash_message "not_updated"
    end
  end

  def destroy
    ids = params[:category][:id] if params[:category].present?
    categories = Category.find_categories ids

    if categories.destroy_all
      flash.now[:success] = flash_message "deleted"
    else
      flash.now[:error] = flash "not_deleted"
    end
  end

  def category_params
    params.require(:category).permit :name, id: []
  end

  def load_categories
    @categories = Category.order(:name).paginate page: params[:page],
      per_page: Settings.paginate.per_page_10
  end
end
