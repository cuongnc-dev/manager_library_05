class AddUniqunessIndexToFollowAuthors < ActiveRecord::Migration[5.0]
  def change
    add_index :follow_authors, [:user_id, :author_id], unique: true
  end
end
