class AddCampidToSummerCampers < ActiveRecord::Migration
  def change
    add_column :summer_campers, :summer_camp_id, :integer
  end
end
