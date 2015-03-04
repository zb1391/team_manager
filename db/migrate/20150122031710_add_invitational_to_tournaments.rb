class AddInvitationalToTournaments < ActiveRecord::Migration
  def up
  	add_column :tournaments, :is_invitational, :boolean, default: true
  end

  def down
  	remove_column :tournaments, :is_invitational
  end
end
