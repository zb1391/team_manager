class CreateHomePageFiles < ActiveRecord::Migration
  def change
    create_table :home_page_files do |t|
      t.string :name

      t.timestamps
    end
  end
end
