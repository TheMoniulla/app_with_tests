FactoryGirl.define do
  factory :group do
    sequence(:name) { |n| "name_#{n}" }
    owner_id { create(:user).id }
  end
end
