FactoryGirl.define do
  factory :currency do
    sequence(:name) { |n| "currency_#{n}" }
  end
end