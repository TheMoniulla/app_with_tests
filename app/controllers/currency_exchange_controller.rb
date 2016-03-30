class CurrencyExchangeController < ApplicationController
  expose(:pln_money) { Money.new(1_00, 'PLN') }
  expose(:eur_money) { Money.new(1_00, 'EUR') }
  expose(:usd_money) { Money.new(1_00, 'USD') }
  expose(:currencies_for_select) { Currency.all.map { |c| [c.name, c.name] } }

  expose(:value) { params[:value] || 0 }
  expose(:base_currency) { params[:base_currency] || 'PLN' }
  expose(:new_currency) { params[:new_currency] || 'PLN' }
  expose(:new_currency_exchange_setting) do
    CurrencyExchangeSetting.new(value: 0, base_currency: 'PLN', new_currency: 'PLN')
  end
  expose(:converted_value) do
    m = Money.new(value, base_currency)
    m.exchange_to(new_currency).to_f * 100
  end
  expose(:currency_exchange_settings) { CurrencyExchangeSetting.all }

  def index
    respond_to do |format|
      format.html
      format.json { render json: {converted_value: converted_value} }
    end
  end
end
