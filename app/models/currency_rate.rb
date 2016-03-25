class CurrencyRate < ActiveRecord::Base
  belongs_to :currency

  validates :rate, :currency_id, presence: true

  def for_chart
    [created_at.to_i * 1000, rate.to_f]
  end

  def self.rate(currency_name)
    Money.new(1_00, currency_name).exchange_to(:PLN).to_f
  end
end
