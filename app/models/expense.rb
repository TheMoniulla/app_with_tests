class Expense < ActiveRecord::Base
  belongs_to :expenses_group
  belongs_to :currency
  belongs_to :shop
  belongs_to :user

  scope :for_user, -> (user) { where(user_id: user.id) }
  scope :for_week, -> (date) { where(created_at: date.beginning_of_week..date.end_of_week)}
  scope :for_group, -> (group) { where(user_id: group.users.map(&:id)) }

  validates :currency_id,
            :expenses_group_id,
            :name,
            :price_value,
            :shop_id,
            :user_id, presence: true
end
