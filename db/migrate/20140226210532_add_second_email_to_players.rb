class AddSecondEmailToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :parent_email2, :string
  end
end
