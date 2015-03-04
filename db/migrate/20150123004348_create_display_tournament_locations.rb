class CreateDisplayTournamentLocations < ActiveRecord::Migration
  def change
    create_table :display_tournament_locations do |t|
      t.integer :display_tournament_id
      t.integer :location_id
    end
  end
end
