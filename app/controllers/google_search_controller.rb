class GoogleSearchController < ApplicationController
  expose(:query) { params[:query] || '' }
  expose(:result) { Google::Search::Web.new(query: query) unless query.blank? }

  def index
    GoogleQuery.create(value: query, count: 1) unless query.blank?
  end
end
