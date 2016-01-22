class RemoveTotalHoursFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :total_time
    add_column :user_semesters, :total_time, :integer, default: 0
  end
end
