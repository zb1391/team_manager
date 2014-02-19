class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.float :price
      t.string :addtional_link

      t.timestamps
    end
  end
end
