class MailerJob < ActiveJob::Base
  def perform(user_id, date_as_string)
    UserMailer.info_email(user_id, date_as_string).deliver_now
  end
end
