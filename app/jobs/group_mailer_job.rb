class GroupMailerJob < ActiveJob::Base
  def perform(date_as_string, group_id)
    GroupMailer.group_info_email(date_as_string, group_id).deliver_now
  end
end
