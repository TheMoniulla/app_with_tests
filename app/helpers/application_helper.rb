module ApplicationHelper
  def price(value)
    number_to_currency(value, unit: '', delimiter: '')
  end

  def date_header(date)
    "#{date.strftime("%Y-%m-%d")} - #{date.end_of_week.strftime("%Y-%m-%d")}"
  end
end
