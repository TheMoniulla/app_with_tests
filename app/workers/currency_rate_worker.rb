class CurrencyRateWorker
  include Sidekiq::Worker

  def perform
    %w(EUR USD).each do |currency_name|
      Currency.find_by_name(currency_name).currency_rates.create(rate: CurrencyRate.rate(currency_name))
    end
  end
end
