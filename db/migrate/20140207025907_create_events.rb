class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :event_time
      t.string :event_location
      t.integer :eventtype_id
      t.integer :team_id

      t.timestamps
    end
  end
end
