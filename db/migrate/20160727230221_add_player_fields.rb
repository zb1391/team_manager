class AddPlayerFields < ActiveRecord::Migration
  def change
    add_column :players, :home_town, :string
    add_column :players, :dob, :date
    add_column :players, :team_preference, :string
    add_column :players, :grade, :integer
  end
end
