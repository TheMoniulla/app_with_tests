class ExampleMailer < ApplicationMailer
  default from: "user@user.com"

  def info_email(user)
    @user = user
    mail(to: @user.email, subject: 'Sample Email')
  end
end
