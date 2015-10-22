class SetDefaultSummerCampName < ActiveRecord::Migration
  def up
    SummerCamp.all.each do |camp|
      camp.camp_type = "SummerCamp"
      camp.save
    end
  end

  def down
  end
end
