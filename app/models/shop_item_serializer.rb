class ShopItemSerializer < ActiveModel::Serializer
  attributes :currency_id,
             :expenses_category_id,
             :id,
             :name,
             :price_value,
             :purchased_on,
             :shop_id,
             :user_id
end
