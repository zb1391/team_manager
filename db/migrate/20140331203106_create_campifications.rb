class CreateCampifications < ActiveRecord::Migration
  def change
    create_table :campifications do |t|
      t.integer :summer_camp_id
      t.integer :summer_camper_id

      t.timestamps
    end
  end
end
