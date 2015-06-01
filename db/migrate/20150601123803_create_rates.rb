class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer :user_id,            null: false
      t.integer :hotel_id,           null: false
      t.integer :rate,     limit: 1, null: false
      t.string  :comment

      t.timestamps                   null: false
    end

    add_index :rates, [:hotel_id, :user_id], unique: true
  end
end
