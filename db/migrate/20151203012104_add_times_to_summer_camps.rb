class AddTimesToSummerCamps < ActiveRecord::Migration
  def up
    add_column :summer_camps, :start_time, :datetime
    add_column :summer_camps, :end_time, :datetime
    add_column :summer_camps, :is_all_day, :boolean, default: true
  end

  def down
    remove_column :summer_camps, :start_time
    remove_column :summer_camps, :end_time
    remove_column :summer_camps, :is_all_day 
  end
end
