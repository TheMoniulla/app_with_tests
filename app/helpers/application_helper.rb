module ApplicationHelper
  def price(value)
    number_to_currency(value, unit: '', delimiter: '')
  end

  def name_of_week(date)
    "Week no. #{date.strftime("%U")}"
  end
end
