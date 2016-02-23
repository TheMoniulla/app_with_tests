class ExpensesGroupsController < ApplicationController
  before_action :get_expenses_group, only: [:edit, :show, :update, :destroy]

  def index
    @expenses_groups = ExpensesGroup.all
  end

  def new
    @expenses_group = ExpensesGroup.new
  end

  def create
    @expenses_group = ExpensesGroup.new(expenses_group_params)
    if @expenses_group.save
      redirect_to expenses_groups_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @expenses_group.update_attributes(expenses_group_params)
      redirect_to expenses_groups_path
    else
      render :edit
    end
  end

  def destroy
    @expenses_group.destroy
    redirect_to expenses_groups_path
  end

  private

  def get_expenses_group
    @expenses_group = ExpensesGroup.find(params[:id])
  end

  def expenses_group_params
    params.require(:expenses_group).permit(:name, :description)
  end
end