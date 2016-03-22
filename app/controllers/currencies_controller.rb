class CurrenciesController < ApplicationController
  respond_to :html, :json

  expose(:currencies)
  expose(:currency, attributes: :currency_params)

  def new
    respond_modal_with currency
  end

  def edit
    respond_modal_with currency
  end

  def create
    currency.save
    respond_modal_with currency, location: currencies_path
  end

  def update
    currency.save
    respond_modal_with currency, location: currencies_path
  end

  def destroy
    currency.destroy
    redirect_to currencies_path
  end

  private

  def currency_params
    params.require(:currency).permit(:name)
  end
end
