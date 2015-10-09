class AddTotalToUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_hours, :integer, default: 0
  end
end
