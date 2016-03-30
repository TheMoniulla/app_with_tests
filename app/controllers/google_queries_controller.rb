class GoogleQueriesController < ApplicationController
  expose(:google_queries)
  expose_decorated(:google_query, attributes: :google_query_params)
  expose(:unique_queries) { google_queries.pluck(:value).uniq }

  def send_statistics_mail
    GoogleStatisticsMailer.statistics_email(current_user).deliver
    redirect_to :back
  end

  private

  def google_query_params
    params.require(:google_query).permit(:value, :count)
  end
end
