class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :hotel_id
      t.string :address
      t.string :address_ii
      t.string :city
      t.string :state
      t.string :country_alpha2, limit: 2

      t.timestamps null: false
    end
  end
end
