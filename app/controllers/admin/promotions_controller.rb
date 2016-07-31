class Admin::PromotionsController < ApplicationController
  load_and_authorize_resource
  before_action :set_params_kind, only: [:index, :new]
  before_action :set_kind, only: [:show, :edit, :update]
  before_action :set_params_form_kind, only: [:create, :destroy]

  def index
    @promotions = Promotion.send(params[:kind]).order(created_at: :desc)
      .paginate page: params[:page], per_page: Settings.paginate.per_page_10
  end

  def show
  end

  def new
  end

  def create
    if @promotion.save
      flash[:success] = t "flashs.created", model_name: @kind.capitalize
      redirect_to admin_informations_path @kind
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @promotion.update_attributes promotion_params
      flash[:success] = t "flashs.updated", model_name: @promotion.kind.capitalize
      redirect_to admin_informations_path @promotion.kind
    else
      render :edit
    end
  end

  def destroy
    ids = params[:promotion][:id] if params[:promotion].present?
    promotions = Promotion.find_promotions ids

    if promotions.destroy_all
      flash[:success] = t "flashs.deleted", model_name: @kind.capitalize
    else
      flash[:error] = t "flashs.not_deleted", model_name: @kind.capitalize
    end
    redirect_to admin_informations_path @kind
  end

  private
  def promotion_params
    params.require(:promotion).permit :title, :content, :picture, :kind
  end

  def set_params_kind
    @kind = params[:kind]
  end

  def set_kind
    @kind = @promotion.kind
  end

  def set_params_form_kind
    @kind = params[:promotion][:kind]
  end
end
