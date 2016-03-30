class CurrencyExchangeSettingsController < ApplicationController
  expose_decorated(:currency_exchange_setting, attributes: :currency_exchange_setting_params)

  def create
    if currency_exchange_setting.save
      redirect_to currency_exchange_index_path
    end
  end

  def destroy
    currency_exchange_setting.destroy
    redirect_to currency_exchange_index_path
  end

  private

  def currency_exchange_setting_params
    params.require(:currency_exchange_setting).permit(:value, :base_currency, :new_currency)
  end
end
