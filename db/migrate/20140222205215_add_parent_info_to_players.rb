class AddParentInfoToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :uniform_number, :integer
    add_column :players, :parent_first_name, :string
    add_column :players, :parent_last_name, :string
    add_column :players, :parent_email, :string
    add_column :players, :parent_cell, :string
    add_column :players, :emergency_phone, :string
  end
end
