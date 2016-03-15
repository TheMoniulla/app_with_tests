class User::WeeklyGroupsExpensesMailsController < User::UserController
  expose(:groups) { current_user.groups }
  expose(:group)
  expose(:expenses) { Expense.for_group(group) }
  expose(:expenses_for_week) { expenses.for_week(date) }
  expose(:date) { params[:date] ? Date.parse(params[:date]) : Date.today }

  def send_group_expenses_mail
    GroupMailer.group_info_email(date.to_s, group.id).deliver
    redirect_to :back
  end
end
