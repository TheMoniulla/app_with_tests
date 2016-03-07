class AddPhotoToExpenses < ActiveRecord::Migration
  def change
    add_attachment :expenses, :photo
  end
end
