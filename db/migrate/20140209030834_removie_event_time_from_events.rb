class RemovieEventTimeFromEvents < ActiveRecord::Migration
  def change
  	remove_column :events, :event_time
  end
end
