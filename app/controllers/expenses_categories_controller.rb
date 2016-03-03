class ExpensesCategoriesController < ApplicationController
  expose(:expenses_categories)
  expose(:expenses_category, attributes: :expenses_category_params)

  def create
    if expenses_category.save
      redirect_to expenses_categories_path
    else
      render :new
    end
  end

  def update
    if expenses_category.save
      redirect_to expenses_categories_path
    else
      render :edit
    end
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
