FactoryGirl.define do
  factory :shop_item do
    sequence(:name) { |n| "shop_item_#{n}" }
    purchased_on Date.today
    price_value 10.0
    currency_id { create(:currency).id }
    user_id { create(:user).id }
    shop_id { create(:shop).id }
    expenses_category_id { create(:expenses_category).id }
  end
end
