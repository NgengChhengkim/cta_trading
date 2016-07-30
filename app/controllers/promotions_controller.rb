class PromotionsController < ApplicationController
  load_and_authorize_resource

  def index
    @kind = params[:kind]
    @promotions = Promotion.send(@kind).paginate page: params[:page],
      per_page: Settings.paginate.per_page
  end

  def show
    @kind = @promotion.kind
    @other_promotions = Promotion.send(@kind).exept_id(@promotion.id)
      .limit Settings.paginate.other_promotion
  end
end
