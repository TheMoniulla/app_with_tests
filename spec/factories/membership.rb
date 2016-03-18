FactoryGirl.define do
  factory :membership do
    user { create(:user) }
    group { create(:group) }
  end
end
