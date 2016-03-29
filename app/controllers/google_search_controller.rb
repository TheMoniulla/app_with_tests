class GoogleSearchController < ApplicationController
  expose(:query) { params[:query] || "" }
  expose(:result) { Google::Search::News.new(query: query) unless query == "" }

  def index
    if query != ""
        GoogleQuery.create(value: query, count: 1)
    end
  end
end
