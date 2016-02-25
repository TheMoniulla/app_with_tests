class ExpenseDecorator < Draper::Decorator
  delegate_all

  def price
    h.number_to_currency(price_value, unit: '', delimiter: '')
  end

  def description_for_display
    description.blank? ? 'No description' : description
  end
end
