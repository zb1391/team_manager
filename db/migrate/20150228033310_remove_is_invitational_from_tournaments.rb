class RemoveIsInvitationalFromTournaments < ActiveRecord::Migration
  def up
  	remove_column :tournaments, :is_invitational
  	remove_column :tournaments, :display_info
  end

  def down
  	add_column :tournaments, :is_invitational, :boolean
  	add_column :tournaments, :display_info, :boolean

  end
end
