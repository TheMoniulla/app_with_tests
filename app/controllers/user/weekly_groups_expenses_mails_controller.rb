class User::WeeklyGroupsExpensesMailsController < User::UserController
  expose(:groups) { current_user.groups }
  expose(:group)
  expose(:expenses) { Expense.for_group(group) }
  expose(:expenses_for_week) { expenses.for_week(date) }
  expose(:date) { params[:date] ? Date.parse(params[:date]) : Date.today }

  def send_group_expenses_mail
    GroupMailer.group_info_email(date, group, expenses_for_week).deliver
    redirect_to user_weekly_groups_expense_path(group.id)
  end
end
