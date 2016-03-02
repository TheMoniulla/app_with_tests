class RenamePurchaseDateToPurchasedOnInShopItems < ActiveRecord::Migration
  def change
    rename_column :shop_items, :purchase_date, :purchased_on
  end
end
