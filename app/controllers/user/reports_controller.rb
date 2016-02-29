class User::ReportsController < User::UserController

  def index
    @groups = current_user.groups
  end

  def show
    @group = Group.find(params[:id])
    @q = Expense.ransack(params[:q])
    @expenses = @q.result.for_group(@group).includes(:user, :shop)
    @expenses_by_group = @expenses.group_by(&:expenses_group_id)
  end
end
