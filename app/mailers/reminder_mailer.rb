class ReminderMailer < ApplicationMailer
  default from: 'admin@user.com'

  def reminder_email(user)
    @user = user
    @date = Date.tomorrow.strftime("%Y-%m-%d")
    @shop_items_for_day = @user.shop_items.for_day(@date)
    mail(to: @user.email, subject: "Expenses for #{@date}")
  end
end
