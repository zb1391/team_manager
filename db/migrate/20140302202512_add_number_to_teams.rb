class AddNumberToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :color, :string
  end
end
