class ExpenseSerializer < ActiveModel::Serializer
  attributes :currency_id,
             :description,
             :expenses_group_id,
             :id,
             :name,
             :price_value,
             :shop_id,
             :user_id
end
