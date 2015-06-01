class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.integer  :user_id, null: false
      t.string   :title, null: false
      t.text     :room_description
      t.monetize :price, amount: {null: true, default: nil}
      t.boolean  :breakfast, default: false
      t.decimal  :average_rate, precision: 5, scale: 3
      t.string   :photo

      t.timestamps
    end
  end
end
