class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id, null: false
      t.integer :hotel_id, null: false
      t.integer :rate, limit: 1, null: false
      t.string :comment
    end

    add_index :ratings, [:user_id, :hotel_id]
  end
end
