class AddAdminToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :admin, :boolean, :default => false
  end
end
