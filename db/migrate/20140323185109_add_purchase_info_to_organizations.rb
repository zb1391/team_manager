class AddPurchaseInfoToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :amount_owe, :float
    add_column :organizations, :amount_paid, :float
    add_column :organizations, :paid_at, :time
  end
end
