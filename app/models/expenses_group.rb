class ExpensesGroup < ActiveRecord::Base
  has_many :expenses

  validates :name, presence: true

  def to_s
    name
  end

  def expenses_for_user(user)
   expenses.where(user_id: user.id)
  end

  def total_price_for_user(user)
    expenses_for_user(user).map(&:price_value).reduce(&:+)
  end
end