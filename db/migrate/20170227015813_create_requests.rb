class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.text :content
      t.datetime :start_day
      t.datetime :end_day
      t.integer :status

      t.timestamps
    end
  end
end
