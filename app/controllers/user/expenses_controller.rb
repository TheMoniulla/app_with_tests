class User::ExpensesController < User::UserController
  before_action :check_ownership, only: [:show, :edit, :update, :destroy]

  expose(:expenses) { current_user.expenses }
  expose(:expense, attributes: :expense_params, finder: :find_by_id)
  expose(:expense_presenter) { expense.decorate }
  expose(:expenses_by_week) { current_user.expenses_by_week }
  expose(:expenses_groups) { ExpensesGroup.all }

  def create
    if expense.save
      redirect_to user_expenses_path
    else
      render :new
    end
  end

  def update
    if expense.save
      redirect_to user_expenses_path
    else
      render :edit
    end
  end

  def destroy
    expense.destroy
    redirect_to user_expenses_path
  end

  private

  def expense_params
    params.require(:expense).permit(:currency_id,
                                    :description,
                                    :expenses_group_id,
                                    :name,
                                    :price_value,
                                    :shop_id)
  end

  def check_ownership
    redirect_to user_expenses_path, alert: 'You are not authorized to see this expense' unless expense
  end
end
