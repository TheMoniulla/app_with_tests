class CreateGoogleQueries < ActiveRecord::Migration
  def change
    create_table :google_queries do |t|
      t.string :value
      t.integer :count
      t.timestamps
    end
  end
end
