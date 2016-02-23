class RemoveShopNameFromExpenses < ActiveRecord::Migration
  def change
    remove_column :expenses, :shop_name, :string
  end
end
