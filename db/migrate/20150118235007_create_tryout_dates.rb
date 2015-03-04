class CreateTryoutDates < ActiveRecord::Migration
  def change
    create_table :tryout_dates do |t|
      t.date :date
      t.integer :tryout_id
    end
  end
end
