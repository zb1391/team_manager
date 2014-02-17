class AddCoachToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :coach_id, :integer
  end
end
