class Admin::GuestsController < ApplicationController
  load_and_authorize_resource
  before_action :load_users, only: [:index, :destroy]
  respond_to :js

  def index
  end

  def show
  end

  def destroy
    ids = params[:guest][:id] if params[:guest].present?
    guests = Guest.find_guests ids

    if guests.destroy_all
      flash.now[:success] = flash_message "deleted"
    else
      flash.now[:error] = flash_message "not_deleted"
    end
  end

  private
  def load_users
    @q = Guest.ransack params[:q]
    @guests = @q.result.order(:name).paginate page: params[:page],
      per_page: Settings.paginate.per_page_10
  end
end
