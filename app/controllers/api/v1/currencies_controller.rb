class Api::V1::CurrenciesController < ApplicationController
  respond_to :json

  expose(:currencies)
  expose(:currency, attributes: :currency_params)

  def index
    render json: currencies
  end

  def show
    render json: currency
  end

  def create
    if currency.save
      render json: currency
    else
      render json: {errors: currency.errors}
    end
  end

  def update
    if currency.save
      render json: currency
    else
      render json: {errors: currency.errors}
    end
  end

  def destroy
    currency.destroy
    render json: {message: 'currency destroyed'}
  end

  private

  def currency_params
    params.require(:currency).permit(:name)
  end
end
