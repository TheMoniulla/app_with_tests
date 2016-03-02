class User::ReportsController < User::UserController
  expose(:groups) { current_user.groups }
  expose(:group)
  expose(:q) { Expense.ransack(params[:q]) }
  expose(:expenses) { q.result.for_group(group).includes(:user) }
  expose(:expenses_by_group) { expenses.group_by(&:expenses_group) }
  expose(:expenses_for_week) { expenses.for_week(date) }
  expose(:date) { params[:date] ? Date.parse(params[:date]) : Date.today }
end
