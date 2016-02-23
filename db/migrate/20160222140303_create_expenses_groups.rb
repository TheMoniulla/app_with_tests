class CreateExpensesGroups < ActiveRecord::Migration
  def change
    create_table :expenses_groups do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
