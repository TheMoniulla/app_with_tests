class User::ExpensesController < User::UserController
  expose(:expense, attributes: :expense_params)
  expose(:expense_presenter) { expense.decorate }
  expose(:expenses_by_week) { current_user.expenses_by_week }
  expose(:expenses_groups) { ExpensesGroup.all }
  expose(:currencies_to_select) { Currency.all }
  expose(:shops_to_select) { Shop.all }
  expose(:expenses_groups_to_select) { ExpensesGroup.all }

  def create
    @expense = current_user.expenses.find_by_id(params[:id])
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
                                    :shop_id,
                                    :user_id)
  end
end
