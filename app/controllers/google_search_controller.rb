class GoogleSearchController < ApplicationController
  expose(:query) { params[:query] || '' }
  expose(:result) { query.present? ? Google::Search::Web.new(query: query) : [] }

  def index
    GoogleQuery.create(value: query, count: 1) if query.present?
  end
end
