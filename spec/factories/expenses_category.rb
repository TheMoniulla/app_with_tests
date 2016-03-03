FactoryGirl.define do
  factory :expenses_category do
    sequence(:name) { |n| "expenses_category_#{n}" }
    description 'description'
  end
end
