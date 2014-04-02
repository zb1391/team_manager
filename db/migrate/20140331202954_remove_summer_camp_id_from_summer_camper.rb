class RemoveSummerCampIdFromSummerCamper < ActiveRecord::Migration
  def change
    remove_column :summer_campers, :summer_camp_id, :integer
  end
end
