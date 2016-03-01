class Api::V1::ExpensesGroupsController < ApplicationController
  respond_to :json

  expose(:expenses_groups)
  expose(:expenses_group, attributes: :expenses_group_params)

  def index
    render json: expenses_groups
  end

  def show
    render json: expenses_group
  end

  def create
    if expenses_group.save
      render json: expenses_group
    else
      render json: {errors: expenses_group.errors}
    end
  end

  def update
    if expenses_group.save
      render json: expenses_group
    else
      render json: {errors: expenses_group.errors}
    end
  end

  def destroy
    expenses_group.destroy
    render json: {message: 'expenses group destroyed'}
  end

  private

  def expenses_group_params
    params.require(:expenses_group).permit(:name, :description)
  end
end
