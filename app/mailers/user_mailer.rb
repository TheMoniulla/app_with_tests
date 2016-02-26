class UserMailer < ApplicationMailer
  default from: 'admin@user.com'

  def info_email(user)
    @user = user
    mail(to: @user.email, subject: 'Weekly report of your expenses')
  end
end
