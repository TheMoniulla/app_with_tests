class Group < ActiveRecord::Base
  has_many :memberships, inverse_of: :group
  has_many :users, through: :memberships
  belongs_to :owner, class_name: 'User'

  validates :name, :owner_id, presence: true
  validates :name, uniqueness: { scope: :owner, message: 'This group already exists!' }
end
