class User::ShopItemsController < User::UserController
  before_action :check_ownership, only: [:edit, :update, :destroy]

  expose(:shop_items) { current_user.shop_items }
  expose_decorated(:shop_item, attributes: :shop_item_params)

  def create
    if shop_item.save
      redirect_to user_shop_items_path
    else
      render :new
    end
  end

  def update
    if shop_item.save
      redirect_to user_shop_items_path
    else
      render :edit
    end
  end

  def destroy
    shop_item.destroy
    redirect_to user_shop_items_path
  end

  private

  def shop_item_params
    params.require(:shop_item).permit(:currency_id,
                                    :expenses_group_id,
                                    :name,
                                    :price_value,
                                    :purchase_date,
                                    :shop_id)
  end

  def check_ownership
    begin
      shop_item
    rescue
      redirect_to user_shop_items_path, alert: 'You are not authorized to see this shop item'
    end
  end
end
