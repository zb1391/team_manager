class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.date :the_date
      t.float :price

      t.timestamps
    end
  end
end
