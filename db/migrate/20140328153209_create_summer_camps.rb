class CreateSummerCamps < ActiveRecord::Migration
  def change
    create_table :summer_camps do |t|
      t.date :start_date
      t.date :end_date
      t.float :price

      t.timestamps
    end
  end
end
