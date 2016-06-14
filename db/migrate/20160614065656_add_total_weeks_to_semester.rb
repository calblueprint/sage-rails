class AddTotalWeeksToSemester < ActiveRecord::Migration
  def change
    add_column :semesters, :weeks_completed, :integer, default: 0
  end
end
