class Api::V1::ShopsController < ApplicationController
  respond_to :json

  expose(:shops)
  expose(:shop, attributes: :shop_params)

  def index
    render json: shops
  end

  def show
    render json: shop
  end

  def create
    if shop.save
      render json: shop
    else
      render json: {errors: shop.errors}
    end
  end

  def update
    if shop.save
      render json: shop
    else
      render json: {errors: shop.errors}
    end
  end

  def destroy
    shop.destroy
    render json: {message: 'shop destroyed'}
  end

  private

  def shop_params
    params.require(:shop).permit(:name)
  end
end
