class AddFieldsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :contact_name, :string
    add_column :organizations, :email, :string
    add_column :organizations, :phone, :string
    add_column :organizations, :tournament_id, :integer
  end
end
