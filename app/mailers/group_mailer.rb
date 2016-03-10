class GroupMailer < ApplicationMailer
  default from: 'admin@user.com'

  def total_price(expenses)
    expenses.to_a.sum(&:price_value)
  end

  def group_info_email(date_as_string, group_id)
    @group = Group.find(group_id)
    @date = Date.parse(date_as_string)
    @expenses_for_week = Expense.for_group(@group).for_week(@date)
    mail(to: @group.users.pluck(:email), subject: 'Weekly report of group expenses')
  end
end
