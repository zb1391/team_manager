class CreateDisplayTournaments < ActiveRecord::Migration
  def change
    create_table :display_tournaments do |t|
      t.string :season
      t.integer :min_grade
      t.integer :max_grade
      t.integer :guaranteed_games
      t.float :price
      t.string :genders
      t.boolean :active, default: true
    end
  end
end
