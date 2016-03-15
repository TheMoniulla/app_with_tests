class GroupMailerWorker
  include Sidekiq::Worker

  def perform(date_as_string, group_id)
    GroupMailer.group_info_email(date_as_string, group_id).deliver
  end
end
