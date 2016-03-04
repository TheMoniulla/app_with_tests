class User::WeeklyGroupsExpensesController < User::UserController
  expose(:groups) { current_user.groups }
  expose(:group)
  expose(:expenses) { Expense.for_group(group) }
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

  def send_group_expenses_mail
    GroupMailer.group_info_email(date, group, expenses_for_week).deliver
    redirect_to user_weekly_groups_expense_path(group.id)
  end
end
