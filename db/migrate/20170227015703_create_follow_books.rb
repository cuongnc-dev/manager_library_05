class CreateFollowBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :follow_books do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
