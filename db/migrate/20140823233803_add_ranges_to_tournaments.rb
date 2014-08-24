class AddRangesToTournaments < ActiveRecord::Migration
  def change
  	add_column :tournaments, :genders, :string, default: "Both"
  	add_column :tournaments, :min_grade, :integer, default: 3
  	add_column :tournaments, :max_grade, :integer, default: 12
  end
end
