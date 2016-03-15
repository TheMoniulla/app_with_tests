class ReminderWorker
  include Sidekiq::Worker

  def perform
    User.all.each do |user|
      ReminderMailer.reminder_email(user).deliver
    end
  end
end
