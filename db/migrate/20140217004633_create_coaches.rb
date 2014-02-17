class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.string :encrypted_password

      t.timestamps
    end
  end
end
