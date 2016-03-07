class User::WeeklyExpensesMailsController < User::UserController
  expose(:user) { current_user }
  expose(:date) { params[:date] ? Date.parse(params[:date]) : Date.today }

  def send_expenses_mail
    UserMailer.info_email(user, date).deliver
    redirect_to user_weekly_expenses_path
  end
end
