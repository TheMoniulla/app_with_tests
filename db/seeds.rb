user1 = User.find_by(email: 'user@user.com') || User.create(email: 'user@user.com', password: 'secret99', password_confirmation: 'secret99')
user2 = User.find_by(email: 'user2@user.com') || User.create(email: 'user2@user.com', password: 'secret99', password_confirmation: 'secret99')

shop1 = Shop.find_or_create_by(name: 'Tesco')
shop2 = Shop.find_or_create_by(name: 'Home & You')

currency_1 = Currency.find_or_create_by(name: 'PLN')
currency_2 = Currency.find_or_create_by(name: 'EUR')

expenses_category_1 = ExpensesCategory.find_or_create_by(name: 'Food')
expenses_category_2 = ExpensesCategory.find_or_create_by(name: 'Clothes')

20.times do
  Expense.create(name: Faker::Superhero.name,
                 price_value: Faker::Number.between(10, 100),
                 description: Faker::Lorem.sentence(3),
                 user: [user1, user2].sample,
                 shop: [shop1, shop2].sample,
                 currency: [currency_1, currency_2].sample,
                 expenses_category: [expenses_category_1, expenses_category_2].sample)
end
