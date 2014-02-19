class RemoveEventLocationFromEvents < ActiveRecord::Migration
  def change
  	remove_column :events, :event_location
  	add_column :events, :location_id, :integer
  end
end
