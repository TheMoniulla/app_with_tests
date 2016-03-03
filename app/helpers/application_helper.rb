module ApplicationHelper
  def price(value)
    number_to_currency(value, unit: '', delimiter: '')
  end

  def name_of_week(date)
    "Week no. #{date.strftime("%U")}"
  end

  def total_price(expenses)
    expenses.to_a.sum(&:price_value)
  end

  def percentage_usage(expense, expenses)
    "#{price(expense.price_value * 100 / total_price(expenses))} %"
  end
end
