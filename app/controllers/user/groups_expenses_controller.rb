class User::GroupsExpensesController < User::UserController
  expose(:groups) { current_user.groups }
  expose(:group)
  expose(:q) { Expense.ransack(params[:q]) }
  expose(:expenses) { q.result.for_group(group).includes(:user) }
  expose(:expenses_by_category) { expenses.group_by(&:expenses_category) }
end
