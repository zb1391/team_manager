class AddDisplayInfoToTournaments < ActiveRecord::Migration
  def up
  	add_column :tournaments, :display_info, :boolean
  end

  def down
  	remove_column :tournaments, :display_info
  end
end
