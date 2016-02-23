class Expense < ActiveRecord::Base
  belongs_to :expenses_group
  belongs_to :user
  belongs_to :shop

  validates :name, :user_id, :shop_id, :price_currency, :price_value, :expenses_group_id, presence: true

  def price
   sprintf('%.2f', price_value)
  end
end