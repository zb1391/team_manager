class AddHotelIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :hotel_id, :integer
  end
end
