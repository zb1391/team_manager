class CreateSummerCampers < ActiveRecord::Migration
  def change
    create_table :summer_campers do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :gender
      t.string :grade
      t.string :email
      t.string :home_phone
      t.string :cell_phone
      t.string :waiver_name
      t.date :waiver_date

      t.timestamps
    end
  end
end
