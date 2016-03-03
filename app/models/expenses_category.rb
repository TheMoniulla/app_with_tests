class ExpensesCategory < ActiveRecord::Base
  has_many :expenses
  has_many :shop_items

  validates :name, presence: true

  def total_price_for_user(user)
    expenses.for_user(user).sum(:price_value)
  end
end
