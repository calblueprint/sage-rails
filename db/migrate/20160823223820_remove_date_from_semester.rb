class RemoveDateFromSemester < ActiveRecord::Migration
  def change
    remove_column :semesters, :date_paused
  end
end
