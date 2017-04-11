class AddUniqunessIndexToFollowBooks < ActiveRecord::Migration[5.0]
  def change
    add_index :follow_books, [:user_id, :book_id], unique: true
  end
end
