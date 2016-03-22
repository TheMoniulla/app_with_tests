class ShopsController < ApplicationController
  respond_to :html, :json

  expose(:shops)
  expose(:shop, attributes: :shop_params)

  def new
    respond_modal_with shop
  end

  def edit
    respond_modal_with shop
  end

  def create
    shop.save
    respond_modal_with shop, location: shops_path
  end

  def update
    shop.save
    respond_modal_with shop, location: shops_path
  end

  def destroy
    shop.destroy
      redirect_to shops_path
  end

  private

  def shop_params
    params.require(:shop).permit(:name)
  end
end
