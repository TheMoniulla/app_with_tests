class CurrencyExchangeController < ApplicationController
  expose(:money_pln) { Money.new(1_00, 'PLN') }
  expose(:money_eur) { Money.new(1_00, 'EUR') }
  expose(:money_usd) { Money.new(1_00, 'USD') }
  expose(:currencies) { Currency.all }
  expose(:value) { params[:value] || 0 }
  expose(:base_currency) { params[:base_currency] || 'PLN' }
  expose(:new_currency) { params[:new_currency] || 'PLN' }
  expose(:converted_value) do
    m = Money.new(value, base_currency)
    m.exchange_to(new_currency).to_f * 100
  end
  expose(:currency_exchange_settings) { CurrencyExchangeSetting.all}
end
