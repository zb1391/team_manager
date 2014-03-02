class AddAgeToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :age, :integer
  end
end
