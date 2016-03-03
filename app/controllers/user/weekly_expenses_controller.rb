class User::WeeklyExpensesController < User::UserController

  expose(:expenses) { current_user.expenses }
  expose(:expenses_for_week) { expenses.for_week(date) }
  expose(:date) { params[:date] ? Date.parse(params[:date]) : Date.today }

  def send_expenses_mail
    @user = current_user
    @date = date
    UserMailer.info_email(@user, @date).deliver
    redirect_to user_weekly_expenses_path
  end
end
