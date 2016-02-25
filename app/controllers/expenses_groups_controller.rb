class ExpensesGroupsController < ApplicationController
  expose(:expenses_group, attributes: :expenses_group_params)
  expose(:expenses_groups) { ExpensesGroup.all }

  def create
    if expenses_group.save
      redirect_to expenses_groups_path
    else
      render :new
    end
  end

  def update
    if expenses_group.save
      redirect_to expenses_groups_path
    else
      render :edit
    end
  end

  def destroy
    expenses_group.destroy
    redirect_to expenses_groups_path
  end

  private

  def expenses_group_params
    params.require(:expenses_group).permit(:name, :description)
  end
end
