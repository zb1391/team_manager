class SetCampsAllDay < ActiveRecord::Migration
  def up
    SummerCamp.all.each do |summer_camp|
      summer_camp.is_all_day = true
      summer_camp.save
    end
  end

  def down
  end
end
