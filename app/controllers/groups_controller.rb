class GroupsController < ApplicationController
  respond_to :html, :json

  before_action :check_access_to_group, only: [:show, :edit, :update, :destroy]
  expose(:groups) { current_user.owned_groups }
  expose_decorated(:group, attributes: :group_params)

  def new
    respond_modal_with group
  end

  def edit
    respond_modal_with group
  end

  def create
   group.save
    respond_modal_with group, location: groups_path
  end

  def update
    group.save
    respond_modal_with group, location: groups_path
  end

  def destroy
    group.destroy
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end

  def check_access_to_group
    begin
      group
    rescue
      redirect_to groups_path, alert: 'You are not authorized to see this group'
    end
  end
end
