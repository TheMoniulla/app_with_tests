class RenameExpensesGroupsToExpensesCategories < ActiveRecord::Migration
  def change
    rename_table :expenses_groups, :expenses_categories
  end
end
