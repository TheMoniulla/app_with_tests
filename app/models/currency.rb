class Currency < ActiveRecord::Base
  has_many :expenses
  has_many :shop_items
  has_many :currency_rates

  validates :name, presence: true, uniqueness: true
end
