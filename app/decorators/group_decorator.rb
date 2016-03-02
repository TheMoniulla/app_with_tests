class GroupDecorator < Draper::Decorator
  delegate_all

  def users_for_display
    users.pluck(:email).sort.join(", ")
  end
end


