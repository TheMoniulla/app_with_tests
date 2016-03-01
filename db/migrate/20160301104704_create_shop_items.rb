class CreateShopItems < ActiveRecord::Migration
  def change
    create_table :shop_items do |t|
      t.string :name
      t.date :purchase_date
      t.decimal :price_value, precision: 8, scale: 2
      t.integer :shop_id
      t.integer :expenses_group_id
      t.integer :currency_id
      t.integer :user_id
      t.timestamps
    end
  end
end
