class ChangeHoursColumn < ActiveRecord::Migration
  def change
    rename_column :users, :hours, :volunteer_type
  end
end
