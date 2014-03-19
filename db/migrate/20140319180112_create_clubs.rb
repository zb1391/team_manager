class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.integer :organization_id
      t.string :coach

      t.timestamps
    end
  end
end
