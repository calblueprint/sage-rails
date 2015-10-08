class AddYearAndSemesterToSemeseter < ActiveRecord::Migration
  def change
    add_column :semesters, :year, :integer
    add_column :semesters, :season, :integer
  end
end
