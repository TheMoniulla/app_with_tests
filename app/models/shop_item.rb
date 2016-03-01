class ShopItem < ActiveRecord::Base
  belongs_to :currency
  belongs_to :shop
  belongs_to :expenses_group
  belongs_to :user

  validates :name, :purchase_date, :price_value, :currency_id, :user_id, presence: true
end
