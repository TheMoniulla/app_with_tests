class User < ActiveRecord::Base
  attr_accessor :current_password

  validates_presence_of :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of :password, within: Devise.password_length, allow_blank: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  has_many :expenses
  has_many :groups, through: :memberships
  has_many :identities
  has_many :memberships, inverse_of: :user
  has_many :owned_groups, class_name: 'Group', foreign_key: :owner_id
  has_many :shop_items

  def twitter
    identities.where(provider: "twitter").first
  end

  def facebook
    identities.where(provider: "facebook").first
  end

  def google_oauth2
    identities.where(provider: "google_oauth2").first
  end

  def total_price_for_week(date)
    expenses.for_week(date).sum(:price_value)
  end

  def total_price_for_future_expenses
    shop_items.sum(:price_value)
  end

  def planned_total_price_for_day(date)
    shop_items.for_day(date).sum(:price_value)
  end

  def compare_expenses_to_last_week(date)
    if total_price_for_week(date) > total_price_for_week(date - 1.week)
      "Your weekly expenses were greater than expenses from last week."
    else
      "Your weekly expenses were lower than expenses from last week."
    end
  end

  def password_required?
    return false if email.blank?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
