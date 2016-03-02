class UserMailer < ApplicationMailer
  default from: 'admin@user.com'

  def info_email(user, date)
    @user = user
    @date = date
    mail(to: @user.email, subject: 'Weekly report of your expenses')
  end
end
