class AddTournamentTypeIdToTournaments < ActiveRecord::Migration
  def up
  	add_column :tournaments, :tournament_type_id, :integer
  end

  def down
  	remove_column :tournaments, :tournament_type_id
  end
end
