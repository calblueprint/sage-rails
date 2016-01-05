class AddColumnsToSemesterAndAnnouncement < ActiveRecord::Migration
  def change
    add_column :announcements, :semester_id, :integer

    add_column :semesters, :season, :integer
    add_column :semesters, :year, :integer
  end
end
