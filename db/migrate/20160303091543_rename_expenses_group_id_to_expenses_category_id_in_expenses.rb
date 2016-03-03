class RenameExpensesGroupIdToExpensesCategoryIdInExpenses < ActiveRecord::Migration
  def change
    rename_column :expenses, :expenses_group_id, :expenses_category_id
  end
end
