class AddPhoneToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :phone, :string
  end
end
