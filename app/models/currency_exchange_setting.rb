class CurrencyExchangeSetting < ActiveRecord::Base
  validates :value, :base_currency, :new_currency, presence: true

end
