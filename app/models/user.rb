class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :expenses

  def expenses_by_week
    expenses.group_by { |u| week_header(u.created_at) }
  end

  private

  def week_header(date)
    "#{date.beginning_of_week.strftime('%Y-%m-%d')} - #{date.end_of_week.strftime('%Y-%m-%d')}"
  end
end
