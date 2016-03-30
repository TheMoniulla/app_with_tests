class CurrencyRatesController < ApplicationController
  expose(:eur_currency_rates) { Currency.find_by(name: 'EUR').currency_rates }
  expose(:usd_currency_rates) { Currency.find_by(name: 'USD').currency_rates }
  expose(:eur_chart_data) { eur_currency_rates.map(&:for_chart) }
  expose(:usd_chart_data) { usd_currency_rates.map(&:for_chart) }
end
