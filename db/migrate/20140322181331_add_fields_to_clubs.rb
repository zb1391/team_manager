class AddFieldsToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :gender, :string
    add_column :clubs, :grade, :string
    add_column :clubs, :email, :string
    add_column :clubs, :cell, :string
  end
end
