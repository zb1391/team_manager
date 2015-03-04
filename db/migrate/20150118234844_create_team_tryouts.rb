class CreateTeamTryouts < ActiveRecord::Migration
  def change
  	create_table :team_tryout_times do |t|
      t.integer :tryout_time_id
      t.integer :team_id
    end
  end
end
