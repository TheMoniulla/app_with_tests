FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@app_with_tests.com" }
    password 'secret33'
    password_conirmation 'secret33'
  end
end
