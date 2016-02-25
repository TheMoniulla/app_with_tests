class ShopsController < ApplicationController
  expose(:shop, attributes: :shop_params)
  expose(:shops) { Shop.all }

  def create
    if shop.save
      redirect_to shops_path
    else
      render :new
    end
  end

  def update
    if shop.save
      redirect_to shops_path
    else
      render :edit
    end
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
