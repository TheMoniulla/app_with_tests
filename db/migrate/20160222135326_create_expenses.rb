class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :name
      t.string :price_currency
      t.decimal :price_value, precision: 8, scale: 2
      t.text :description
      t.string :shop_name
      t.integer :expenses_group_id
      t.integer :user_id
      t.timestamps
    end
  end
end
