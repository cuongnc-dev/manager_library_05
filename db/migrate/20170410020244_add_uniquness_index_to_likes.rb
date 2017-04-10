class AddUniqunessIndexToLikes < ActiveRecord::Migration[5.0]
  def change
    add_index :likes, [:user_id, :book_id], unique: true
  end
end
