class ChangeHoursToTime < ActiveRecord::Migration
  def change
    rename_column :users, :total_hours, :total_time
  end
end
