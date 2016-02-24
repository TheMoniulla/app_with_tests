class CurrenciesController < ApplicationController
  before_action :get_currency, only: [ :edit, :update, :destroy]

  def new
    @currency = Currency.new
  end

  def index
    @currencies = Currency.all
  end

  def edit
  end

  def create
    @currency = Currency.new(currency_params)
    if @currency.save
      redirect_to currencies_path
    else
      render :new
    end
  end

  def update
    if @currency.update_attributes(currency_params)
      redirect_to currencies_path
    else
      render :edit
    end
  end

  def destroy
    @currency.destroy
    redirect_to currencies_path
  end

  private

  def get_currency
    @currency = Currency.find(params[:id])
  end

  def currency_params
    params.require(:currency).permit(:name)
  end
end