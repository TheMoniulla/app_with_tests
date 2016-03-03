class Api::V1::ExpensesController < ApplicationController
  respond_to :json

  expose(:expenses)
  expose(:expense, attributes: :expense_params)

  def index
    render json: expenses
  end

  def show
    render json: expense
  end

  def create
    if expense.save
      render json: expense
    else
      render json: {errors: expense.errors}
    end
  end

  def update
    if expense.save
      render json: expense
    else
      render json: {errors: expense.errors}
    end
  end

  def destroy
    expense.destroy
    render json: {message: 'expense destroyed'}
  end

  private

  def expense_params
    params.require(:expense).permit(:currency_id,
                                    :description,
                                    :expenses_category_id,
                                    :name,
                                    :price_value,
                                    :shop_id,
                                    :user_id)
  end
end
