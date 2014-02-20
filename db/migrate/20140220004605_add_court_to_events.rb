class AddCourtToEvents < ActiveRecord::Migration
  def change
    add_column :events, :court, :integer
  end
end
