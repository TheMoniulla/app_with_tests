module ApplicationHelper
  def price(value)
    number_to_currency(value, unit: '', delimiter: '')
  end
end
