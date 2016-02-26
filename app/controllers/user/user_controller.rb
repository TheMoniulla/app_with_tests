class User::UserController < ApplicationController
  before_action :check_current_user

  private

  def create

  end

  def check_current_user
    redirect_to root_path, alert: 'You have to be logged in to see this page.' unless current_user
  end
end
