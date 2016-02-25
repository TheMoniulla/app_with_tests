class RemovePriceCurrencyFromExpenses < ActiveRecord::Migration
  def change
    remove_column :expenses, :price_currency, :string
  end
end
