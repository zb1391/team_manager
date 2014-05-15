class AddAttachmentTheFileToHomePageFiles < ActiveRecord::Migration
  def self.up
    change_table :home_page_files do |t|
      t.attachment :the_file
    end
  end

  def self.down
    drop_attached_file :home_page_files, :the_file
  end
end
