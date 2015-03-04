class CreateTournamentLocations < ActiveRecord::Migration
  def change
    create_table :tournament_locations do |t|
      t.integer :location_id
      t.integer :tournament_id
    end
  end
end
