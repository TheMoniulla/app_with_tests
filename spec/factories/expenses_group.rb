FactoryGirl.define do
  factory :expenses_group do
    sequence(:name) { |n| "expenses_group_#{n}" }
    description 'description'
  end
end