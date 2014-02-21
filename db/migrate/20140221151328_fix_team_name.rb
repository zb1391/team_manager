class FixTeamName < ActiveRecord::Migration
  def change
  	remove_column :teams, :team_name
  	add_column	:teams, :grade, :string
  	add_column  :teams, :team_type, :string
  end
end
