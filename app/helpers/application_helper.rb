module ApplicationHelper
  def price(value)
    number_to_currency(value, unit: '', delimiter: '')
  end

  def name_of_week(date)
    "Week no. #{date.strftime("%U")}"
  end

  def total_price_for_group(expenses)
    expenses.map(&:price_value).reduce(&:+)
  end
end
