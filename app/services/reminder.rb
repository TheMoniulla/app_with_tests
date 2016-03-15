class Reminder
  def deliver
    User.find_each { |user| ReminderMailer.delay.reminder_email(user) }
  end
  handle_asynchronously :deliver
end
