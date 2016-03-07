class User::GroupsExpensesController < User::UserController
  before_action :check_access_to_group, only: [:show]
  expose(:groups) { current_user.groups }
  expose(:group)
  expose(:q) { Expense.ransack(params[:q]) }
  expose(:expenses) { q.result.for_group(group).includes(:user) }
  expose(:expenses_by_category) { expenses.group_by(&:expenses_category) }

  private

  def check_access_to_group
    begin
      group
    rescue
      redirect_to user_groups_expenses_path, alert: 'You are not authorized to see this group'
    end
  end
end
