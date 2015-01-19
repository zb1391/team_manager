class CreateTryoutTimes < ActiveRecord::Migration
  def change
    create_table :tryout_times do |t|
      t.time :time
      t.integer :tryout_date_id
    end
  end
end
