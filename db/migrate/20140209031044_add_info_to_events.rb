class AddInfoToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :the_date, :date
  	add_column :events, :the_time, :time
  end
end
