class Api::V1::ShopItemsController < ApplicationController
  respond_to :json

  expose(:shop_items)
  expose(:shop_item, attributes: :shop_item_params)

  def index
    render json: shop_items
  end

  def show
    render json: shop_item
  end

  def create
    if shop_item.save
      render json: shop_item
    else
      render json: {errors: shop_item.errors}
    end
  end

  def update
    if shop_item.save
      render json: shop_item
    else
      render json: {errors: shop_item.errors}
    end
  end

  def destroy
    shop_item.destroy
    render json: {message: 'shop item destroyed'}
  end

  private

  def shop_item_params
    params.require(:shop_item).permit(:currency_id,
                                    :expenses_category_id,
                                    :name,
                                    :price_value,
                                    :purchased_on,
                                    :shop_id,
                                    :user_id)
  end
end
