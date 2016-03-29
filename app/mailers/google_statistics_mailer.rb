class GoogleStatisticsMailer < ApplicationMailer
  default from: 'admin@user.com'

  def statistics_email(user)
    @user = user
    @google_queries = GoogleQuery.all
    @unique_queries = @google_queries.map(&:value).uniq
    mail(to: @user.email, subject: 'Google search statistics')
  end
end
