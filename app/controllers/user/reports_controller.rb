class User::ReportsController < User::UserController

  def index
    @groups = current_user.groups
  end

  def show
    @group = Group.find(params[:id])
    @expenses = Expense.for_group(@group)
  end
end
