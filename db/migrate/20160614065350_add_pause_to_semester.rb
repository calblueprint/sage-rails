class AddPauseToSemester < ActiveRecord::Migration
  def change
    add_column :semesters, :paused, :boolean, default: false
    add_column :semesters, :date_paused, :datetime
  end
end
