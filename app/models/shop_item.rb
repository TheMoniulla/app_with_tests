class ShopItem < ActiveRecord::Base
  belongs_to :currency
  belongs_to :shop
  belongs_to :expenses_category
  belongs_to :user

  scope :for_day, -> (date) { where(purchased_on: date) }

  validates :name, :purchased_on, :price_value, :currency_id, :user_id, presence: true
end
