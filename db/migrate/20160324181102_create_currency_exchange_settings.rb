class CreateCurrencyExchangeSettings < ActiveRecord::Migration
  def change
    create_table :currency_exchange_settings do |t|
      t.decimal :value
      t.string :base_currency
      t.string :new_currency
      t.timestamps
    end
  end
end
