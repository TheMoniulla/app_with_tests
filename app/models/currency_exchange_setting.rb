class CurrencyExchangeSetting < ActiveRecord::Base
  validates :value, :base_currency, :new_currency, presence: true

  def for_display
    "#{value}, #{base_currency}, #{new_currency}"
  end
end
