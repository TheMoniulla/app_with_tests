FactoryGirl.define do
  factory :expense do
    sequence(:name) { |n| "expense_#{n}" }
    price_value 10.0
    currency_id { create(:currency).id }
    user_id { create(:user).id }
    shop_id { create(:shop).id }
    expenses_group_id { create(:expenses_group).id }
    description 'description'
  end
end
