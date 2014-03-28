class AddAmountsToSummerCampers < ActiveRecord::Migration
  def change
    add_column :summer_campers, :amount_owe, :float
    add_column :summer_campers, :amount_paid, :float
  end
end
