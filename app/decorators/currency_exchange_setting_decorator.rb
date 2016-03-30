class CurrencyExchangeSettingDecorator < Draper::Decorator
  delegate_all

  def for_display
    "#{value}, #{base_currency}, #{new_currency}"
  end
end
