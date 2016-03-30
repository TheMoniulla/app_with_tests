class GoogleQueryDecorator < Draper::Decorator
  delegate_all

  def search_date_for_display(query)
    query.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end
end
