class User::WeeklyGroupsExpensesController < User::UserController
  expose(:groups) { current_user.groups }
  expose(:group)
  expose(:expenses) { Expense.for_group(group).includes(:user) }
  expose(:expenses_for_week) { expenses.for_week(date) }
  expose(:date) { params[:date] ? Date.parse(params[:date]) : Date.today }

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'weekly_report', layout: "pdf.html.haml"
      end
    end
  end
end
