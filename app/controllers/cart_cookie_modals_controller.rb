class CartCookieModalsController < ApplicationController
  def show
    @product = Product.find params[:id]
    respond_to do |format|
      format.js
    end
  end
end
