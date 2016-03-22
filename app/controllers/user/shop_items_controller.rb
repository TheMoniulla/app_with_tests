class User::ShopItemsController < User::UserController
  before_action :check_ownership, only: [:edit, :update, :destroy]
  respond_to :html, :json

  expose(:shop_items) { current_user.shop_items }
  expose_decorated(:shop_item, attributes: :shop_item_params)
  expose(:shop_items_for_day) { current_user.shop_items.for_day(date) }
  expose(:date) { params[:date] ? Date.parse(params[:date]) : Date.today }

  def new
    respond_modal_with shop_item
  end

  def edit
    respond_modal_with shop_item
  end

  def create
    shop_item.save
    respond_modal_with shop_item, location: user_shop_items_path
  end

  def update
    shop_item.save
    respond_modal_with shop_item, location: user_shop_items_path
  end

  def destroy
    shop_item.destroy
    redirect_to user_shop_items_path
  end

  private

  def shop_item_params
    params.require(:shop_item).permit(:currency_id,
                                    :expenses_category_id,
                                    :name,
                                    :price_value,
                                    :purchased_on,
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
