class AddPasswordToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :encrypted_password, :string
    add_column :teams, :salt, :string
  end
end
