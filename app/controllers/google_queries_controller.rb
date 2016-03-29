class GoogleQueriesController < ApplicationController
  expose(:google_queries)
  expose(:google_query, attributes: :google_query_params)
  expose(:unique_queries) { google_queries.map(&:value).uniq }

  def send_statistics_mail
    GoogleStatisticsMailer.statistics_email(current_user).deliver
    redirect_to :back
  end

  private

  def google_query_params
    params.require(:google_query).permit(:value, :count)
  end
end
