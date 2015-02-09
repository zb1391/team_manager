class CreateHomePagePanel < ActiveRecord::Migration
  def change
    create_table :home_page_panels do |t|
    	t.text :html
    	t.string :additional_link
    	t.string :additional_link_text
    	t.boolean :is_active, default: :false
    	t.integer :priority_order
    	t.string :title
    end
  end
end
