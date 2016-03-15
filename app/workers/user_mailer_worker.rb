class UserMailerWorker
  include Sidekiq::Worker

  def perform(user_id, date_as_string)
    UserMailer.info_email(user_id, date_as_string).deliver
  end
end
