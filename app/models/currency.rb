class Currency < ActiveRecord::Base
  has_many :expenses
  has_many :shop_items

  validates :name, presence: true
end
