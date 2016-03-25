class CreateCurrencyRates < ActiveRecord::Migration
  def change
    create_table :currency_rates do |t|
      t.decimal :rate
      t.integer :currency_id
      t.timestamps
    end
  end
end
