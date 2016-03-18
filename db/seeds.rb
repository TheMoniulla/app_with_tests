user1 = User.find_by(email: 'user@user.com') || User.create(email: 'user@user.com', password: 'secret99', password_confirmation: 'secret99')
user2 = User.find_by(email: 'user2@user.com') || User.create(email: 'user2@user.com', password: 'secret99', password_confirmation: 'secret99')
user3 = User.find_by(email: 'user3@user.com') || User.create(email: 'user3@user.com', password: 'secret99', password_confirmation: 'secret99')
user4 = User.find_by(email: 'user4@user.com') || User.create(email: 'user4@user.com', password: 'secret99', password_confirmation: 'secret99')

shop1 = Shop.find_or_create_by(name: 'Tesco')
shop2 = Shop.find_or_create_by(name: 'Home & You')
shop3 = Shop.find_or_create_by(name: 'H&M')
shop4 = Shop.find_or_create_by(name: 'Rik')
shop5 = Shop.find_or_create_by(name: 'Apple Store')
shop6 = Shop.find_or_create_by(name: 'Rossmann')
shop7 = Shop.find_or_create_by(name: 'Empik')

currency_1 = Currency.find_or_create_by(name: 'PLN')

expenses_category_1 = ExpensesCategory.find_or_create_by(name: 'Food')
expenses_category_2 = ExpensesCategory.find_or_create_by(name: 'Clothes and Shoes')
expenses_category_3 = ExpensesCategory.find_or_create_by(name: 'Toys')
expenses_category_4 = ExpensesCategory.find_or_create_by(name: 'Electronic Equipment')
expenses_category_5 = ExpensesCategory.find_or_create_by(name: 'Cosmetics')
expenses_category_6 = ExpensesCategory.find_or_create_by(name: 'Household Articles ')
expenses_category_7 = ExpensesCategory.find_or_create_by(name: 'Books')

20.times do
  Expense.create(name: Faker::Superhero.name,
                 price_value: Faker::Commerce.price,
                 description: Faker::Lorem.sentence(3),
                 user: [user1, user2, user3, user4].sample,
                 shop: [shop1, shop2, shop3, shop4, shop5, shop6, shop7].sample,
                 currency: currency_1,
                 expenses_category: [expenses_category_1,
                                     expenses_category_2,
                                     expenses_category_3,
                                     expenses_category_4,
                                     expenses_category_5,
                                     expenses_category_6,
                                     expenses_category_7].sample,
                 created_at: Faker::Date.between(22.days.ago, Date.today),
                 photo: Faker::Placeholdit.image("50x50"))
end
