class RenameExpensesGroupIdToExpensesCategoryIdInShopItems < ActiveRecord::Migration
  def change
    rename_column :shop_items, :expenses_group_id, :expenses_category_id
  end
end
