class User::ExpensesController < User::UserController
  before_action :check_ownership, only: [:show, :edit, :update, :destroy]

  expose(:expenses) { current_user.expenses }
  expose_decorated(:expense, attributes: :expense_params)
  expose(:expenses_for_week) { current_user.expenses.for_week(date) }
  expose(:expenses_groups) { ExpensesGroup.all }
  expose(:date) { params[:date] ? Date.parse(params[:date]) : Date.today }

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

  def send_expenses_mail
    @user = current_user
    UserMailer.info_email(@user).deliver
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
    begin
      expense
    rescue
      redirect_to user_expenses_path, alert: 'You are not authorized to see this expense'
    end
  end
end
