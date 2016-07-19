class Admin::SlideImagesController < ApplicationController
  load_and_authorize_resource

  def index
    @slide_images = SlideImage.order(created_at: :desc).paginate page: params[:page],
      per_page: Settings.paginate.per_page_10
  end

  def show
  end

  def new
  end

  def create
    if @slide_image.save
      flash[:success] = flash_message "created"
      redirect_to admin_slide_images_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @slide_image.update_attributes slide_image_params
      flash[:success] = flash_message "updated"
      redirect_to admin_slide_images_path
    else
      render :edit
    end
  end

  def destroy
    ids = params[:slide_image][:id] if params[:slide_image].present?
    slide_images = SlideImage.find_slide_images ids

    if slide_images.destroy_all
      flash[:success] = flash_message "deleted"
    else
      flash[:error] = flash_message "not_deleted"
    end
    redirect_to admin_slide_images_path
  end

  def slide_image_params
    params.require(:slide_image).permit :picture, :heading1, :heading2,
      :heading3, :heading4
  end
end
