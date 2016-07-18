class Admin::PromotionsController < ApplicationController
  load_and_authorize_resource

  def index
    @promotions = Promotion.order(created_at: :desc).paginate page: params[:page],
      per_page: Settings.paginate.per_page_10
  end

  def show
  end

  def new
  end

  def create
    if @promotion.save
      flash[:success] = flash_message "created"
      redirect_to admin_promotions_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @promotion.update_attributes promotion_params
      flash[:success] = flash_message "updated"
      redirect_to admin_promotions_path
    else
      render :edit
    end
  end

  def destroy
    ids = params[:promotion][:id] if params[:promotion].present?
    promotions = Promotion.find_promotions ids

    if promotions.destroy_all
      flash[:success] = flash_message "deleted"
    else
      flash[:error] = flash_message "not_deleted"
    end
    redirect_to admin_promotions_path
  end

  def promotion_params
    params.require(:promotion).permit :title, :content, :picture
  end
end
