class UpdateTournamentFields < ActiveRecord::Migration
  def up
  	add_column :tournaments, :end_registration_date, :date
  	remove_column :tournaments, :active
  end

  def down
  	remove_column :tournaments, :end_registration_date
  	add_column :tournaments, :active, :boolean
  end
end
