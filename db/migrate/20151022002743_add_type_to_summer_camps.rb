class AddTypeToSummerCamps < ActiveRecord::Migration
  def up
    add_column :summer_camps, :camp_type, :string
  end

  def down
    remove_column :summer_camps, :camp_type
  end
end
