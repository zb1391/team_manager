class AddEndRegistrationDateToSummerCamps < ActiveRecord::Migration
  def change
    add_column :summer_camps, :end_registration_date, :date
  end
end
