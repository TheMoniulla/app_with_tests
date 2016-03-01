class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :expenses
  has_many :shop_items
  has_many :memberships, inverse_of: :user
  has_many :groups, through: :memberships
  has_many :owned_groups, class_name: 'Group', foreign_key: :owner_id

  def total_price_for_week(date)
    expenses.for_week(date).sum(:price_value)
  end

  def total_price_for_future_expenses
    shop_items.sum(:price_value)
  end

  def compare_expenses_to_last_week(date)
    if total_price_for_week(date) > total_price_for_week(date - 1.week)
      "Your weekly expenses were greater than expenses from last week."
    else
      "Your weekly expenses were lower than expenses from last week."
    end
  end
end
