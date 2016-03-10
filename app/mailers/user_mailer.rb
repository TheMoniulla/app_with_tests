class UserMailer < ApplicationMailer
  default from: 'admin@user.com'

  def info_email(user_id, date_as_string)
    @user = User.find(user_id)
    @date = Date.parse(date_as_string)
    mail(to: @user.email, subject: 'Weekly report of your expenses')
  end
end
