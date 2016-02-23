FactoryGirl.define do
  factory :shop do
    sequence(:name) { |n| "name_#{n}" }
  end
end