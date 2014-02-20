class AddParentsToPlayers < ActiveRecord::Migration
  def change
  	add_column :players, :parents, :string, array: true, default: '{}'
  end
end
