class Admin::UsersController < ApplicationController
  load_and_authorize_resource
  before_action :load_users, only: [:index, :create, :update, :destroy]
  respond_to :js

  def index
  end

  def show
  end

  def new
  end

  def create
    if @user.save
      flash.now[:success] = flash_message "created"
    else
      flash.now[:error] = flash_message "not_created"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash.now[:success] = flash_message "updated"
    else
      flash.now[:error] = flash_message "not_updated"
    end
  end

  def destroy
    ids = params[:user][:id] if params[:user].present?
    users = User.find_users ids

    if users.destroy_all
      flash.now[:success] = flash_message "deleted"
    else
      flash.now[:error] = flash_message "not_deleted"
    end
  end

  def user_params
    params.require(:user).permit :name, :email, :role, :phone_number,
      :password, :password_confirmation
  end

  def load_users
    @q = User.ransack params[:q]
    @users = @q.result.order(:name).paginate page: params[:page],
      per_page: Settings.paginate.per_page_10
  end
end
