class Expense < ActiveRecord::Base
  belongs_to :expenses_group
  belongs_to :currency
  belongs_to :shop
  belongs_to :user

  scope :for_user, -> (user) { where(user_id: user.id) }

  validates :currency_id,
            :expenses_group_id,
            :name,
            :price_value,
            :shop_id,
            :user_id, presence: true
end