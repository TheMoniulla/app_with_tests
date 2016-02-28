class GroupsController < ApplicationController
  before_action :check_ownership, only: [:show, :edit, :update, :destroy]
  expose(:groups) { current_user.owned_groups }
  expose(:group, attributes: :group_params, finder: :find_by_id)
  expose(:group_presenter) { group.decorate }

  def create
    if group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def update
    if group.save
      redirect_to groups_path
    else
      render :edit
    end
  end

  def destroy
    group.destroy
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end

  def check_ownership
    redirect_to groups_path, alert: 'You are not authorized to see this group' unless group
  end
end
