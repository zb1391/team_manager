class CreateHotelifications < ActiveRecord::Migration
  def change
    create_table :hotelifications do |t|
      t.integer :hotel_id
      t.integer :event_id

      t.timestamps
    end
  end
end
