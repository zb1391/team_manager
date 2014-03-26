class CreatePaymentNotifications < ActiveRecord::Migration
  def change
    create_table :payment_notifications do |t|
      t.text :params
      t.integer :organization_id
      t.string :status
      t.string :transaction_id
      t.float :amount

      t.timestamps
    end
  end
end
