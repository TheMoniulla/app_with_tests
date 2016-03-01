class Api::V1::GroupsController < ApplicationController
  respond_to :json

  expose(:groups)
  expose(:group, attributes: :group_params)

  def index
    render json: groups
  end

  def show
    render json: group
  end

  def create
    if group.save
      render json: group
    else
      render json: {errors: group.errors}
    end
  end

  def update
    if group.save
      render json: group
    else
      render json: {errors: group.errors}
    end
  end

  def destroy
    group.destroy
    render json: {message: 'group destroyed'}
  end

  private

  def group_params
    params.require(:group).permit(:name, :owner_id)
  end
end
