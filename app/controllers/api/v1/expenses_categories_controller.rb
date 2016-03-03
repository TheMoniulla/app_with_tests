class Api::V1::ExpensesCategoriesController < ApplicationController
  respond_to :json

  expose(:expenses_categories)
  expose(:expenses_category, attributes: :expenses_category_params)

  def index
    render json: expenses_categories
  end

  def show
    render json: expenses_category
  end

  def create
    if expenses_category.save
      render json: expenses_category
    else
      render json: {errors: expenses_category.errors}
    end
  end

  def update
    if expenses_category.save
      render json: expenses_category
    else
      render json: {errors: expenses_category.errors}
    end
  end

  def destroy
    expenses_category.destroy
    render json: {message: 'expenses category destroyed'}
  end

  private

  def expenses_category_params
    params.require(:expenses_category).permit(:name, :description)
  end
end
