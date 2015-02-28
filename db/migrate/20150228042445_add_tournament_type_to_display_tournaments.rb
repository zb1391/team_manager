class AddTournamentTypeToDisplayTournaments < ActiveRecord::Migration
  def up
  	add_column :display_tournaments, :tournament_type_id, :integer
  end

  def down
  	remove_column :display_tournaments, :tournament_type_id
  end
end
