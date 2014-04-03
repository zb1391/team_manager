class AddDateToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :start_date, :date
  end
end
