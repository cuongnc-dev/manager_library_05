class AddUniqunessIndexToRates < ActiveRecord::Migration[5.0]
  def change
    add_index :rates, [:user_id, :book_id], unique: true
  end
end
