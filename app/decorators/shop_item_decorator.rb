class ShopItemDecorator < Draper::Decorator
  delegate_all

  def price
    h.number_to_currency(price_value, unit: '', delimiter: '')
  end
end
