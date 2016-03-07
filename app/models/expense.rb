class Expense < ActiveRecord::Base
  belongs_to :expenses_category
  belongs_to :currency
  belongs_to :shop
  belongs_to :user

  has_attached_file :photo, styles: {thumb: "50x50>"}, default_url: "/assets/photos/:style/missing.png"

  validates_attachment :photo,
                       content_type: {content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]}

  scope :for_user, -> (user) { where(user_id: user.id) }
  scope :for_week, -> (date) { where(created_at: date.beginning_of_week..date.end_of_week) }
  scope :for_group, -> (group) { where(user_id: group.user_ids) }

  validates :currency_id,
            :expenses_category_id,
            :name,
            :price_value,
            :shop_id,
            :user_id, presence: true
end
