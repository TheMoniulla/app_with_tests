class ReminderWorker
  include Sidekiq::Worker

  def perform
    User.find_each do |user|
      ReminderMailer.reminder_email(user).deliver
    end
  end
end
