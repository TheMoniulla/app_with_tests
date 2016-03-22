class ExpensesCategoriesController < ApplicationController
  respond_to :html, :json

  expose(:expenses_categories)
  expose(:expenses_category, attributes: :expenses_category_params)

  def new
    respond_modal_with expenses_category
  end

  def edit
    respond_modal_with expenses_category
  end

  def create
    expenses_category.save
    respond_modal_with expenses_category, location: expenses_categories_path
  end

  def update
    expenses_category.save
    respond_modal_with expenses_category, location: expenses_categories_path
  end

  def destroy
    expenses_category.destroy
    redirect_to expenses_categories_path
  end

  private

  def expenses_category_params
    params.require(:expenses_category).permit(:name, :description)
  end
end
