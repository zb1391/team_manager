class AddTeamIdToHomePageFiles < ActiveRecord::Migration
  def up
  	add_column :home_page_files, :team_id, :integer
  end

  def down
  	remove_column :home_page_files, :team_id
  end
end
