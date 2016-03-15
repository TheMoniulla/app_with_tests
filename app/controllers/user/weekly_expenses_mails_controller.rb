class User::WeeklyExpensesMailsController < User::UserController
  expose(:user) { current_user }
  expose(:date) { params[:date] ? Date.parse(params[:date]) : Date.today }

  def send_expenses_mail
    UserMailerWorker.perform_async(user.id, date.to_s)
    redirect_to :back
  end
end
