class CurrenciesController < ApplicationController
  expose(:currency, attributes: :currency_params)
  expose(:currencies) { Currency.all }

  def create
    if currency.save
      redirect_to currencies_path
    else
      render :new
    end
  end

  def update
    if currency.save
      redirect_to currencies_path
    else
      render :edit
    end
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
