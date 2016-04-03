FactoryGirl.define do
  factory :currency_rate do
    rate 4.28
    currency_id { create(:currency).id }
  end
end
