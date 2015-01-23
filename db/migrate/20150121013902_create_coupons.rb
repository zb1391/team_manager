class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :title
      t.string :description
      t.boolean :active, default: true
      t.date :active_until
    end
  end
end
