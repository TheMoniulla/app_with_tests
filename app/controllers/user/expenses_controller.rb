class User::ExpensesController < User::UserController
  before_action :get_expense, only: [:edit, :show, :update, :destroy]

  def index
    @expenses = current_user.expenses.all
    @expenses_by_week = current_user.expenses_by_week
    @expenses_groups = ExpensesGroup.all
  end

  def new
    @expense = current_user.expenses.new
  end

  def create
    @expense = current_user.expenses.new(expense_params)
    if @expense.save
      redirect_to user_expenses_path
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @expense.update_attributes(expense_params)
      redirect_to user_expenses_path
    else
      render :edit
    end
  end

  def destroy
    @expense.destroy
    redirect_to user_expenses_path
  end

  private

  def get_expense
    @expense = current_user.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:currency_id,
                                    :description,
                                    :expenses_group_id,
                                    :name,
                                    :price_value,
                                    :shop_id,
                                    :user_id)
  end
end