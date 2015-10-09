class AddHoursToUser < ActiveRecord::Migration
  def change
    add_column :users, :hours, :integer, default: 0
  end
end
