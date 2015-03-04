class AddSeasonToTryout < ActiveRecord::Migration
  def up
  	add_column :tryouts, :season, :string
  end

  def down
  	remove_column :tryouts, :season
  end
end
