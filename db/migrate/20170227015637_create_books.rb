class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :image
      t.text :description
      t.integer :page_number
      t.integer :current
      t.references :category, foreign_key: true
      t.references :author, foreign_key: true
      t.references :publisher, foreign_key: true

      t.timestamps
    end
  end
end
