class GroupDecorator < Draper::Decorator
  delegate_all

  def users_for_display
    users.order(:email).pluck(:email).join(", ")
  end
end


