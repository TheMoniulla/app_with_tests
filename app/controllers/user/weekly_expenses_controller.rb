class User::WeeklyExpensesController < User::UserController

  expose(:expenses) { current_user.expenses }
  expose(:expenses_for_week) { expenses.for_week(date) }
  expose(:date) { params[:date] ? Date.parse(params[:date]) : Date.today }

  def index
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'weekly_report', layout: "pdf.html.haml"
      end
    end
  end
end
