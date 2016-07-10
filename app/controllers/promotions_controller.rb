class PromotionsController < ApplicationController
  load_and_authorize_resource

  def index
    @promotions = Promotion.paginate page: params[:page],
      per_page: Settings.paginate.per_page
  end

  def show
    @other_promotions = Promotion.limit Settings.paginate.other_promotion
  end
end
