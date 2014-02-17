class AddSaltToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :salt, :string
  end
end
