class User::ExpensesController < User::UserController
  before_action :check_ownership, only: [:show, :edit, :update, :destroy]

  expose(:expenses) { current_user.expenses }
  expose_decorated(:expense, attributes: :expense_params)
  expose(:expenses_categories) { ExpensesCategory.all }
  expose(:expenses_import) { ExpensesImport.new }
  expose(:total_price_category) do
    expenses_categories.map { |category| category.expenses.for_user(current_user).sum(:price_value).to_f }
  end

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

  def import
    if params[:expenses_import] && params[:expenses_import][:file]
      begin
        ExpensesImport.new(params[:expenses_import][:file]).import_for(current_user)
        redirect_to user_expenses_path, notice: 'Success.'
      rescue
        redirect_to user_expenses_path, alert: 'Wrong data format.'
      end
    else
      redirect_to user_expenses_path, alert: 'You have to upload file.'
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:currency_id,
                                    :description,
                                    :expenses_category_id,
                                    :name,
                                    :photo,
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
