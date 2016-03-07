class GroupMailer < ApplicationMailer
  default from: 'admin@user.com'

  def total_price(expenses)
    expenses.to_a.sum(&:price_value)
  end

  def group_info_email(date, group, expenses_for_week)
    @date = date
    @group = group
    @expenses_for_week = expenses_for_week
    mail(to: group.users.pluck(:email), subject: 'Weekly report of group expenses')
  end
end
