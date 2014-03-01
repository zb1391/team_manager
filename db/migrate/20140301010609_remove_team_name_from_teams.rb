class RemoveTeamNameFromTeams < ActiveRecord::Migration
  def change
  	remove_column :teams, :team_name
  end
end
