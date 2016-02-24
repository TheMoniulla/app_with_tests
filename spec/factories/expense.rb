FactoryGirl.define do
  factory :expense do
    sequence(:name) { |n| "expense_#{n}" }
    price_value 10.0
    currency { create(:currency) }
    user { create(:user) }
    shop { create(:shop) }
    expenses_group { create(:expenses_group) }
    description 'description'
  end
end