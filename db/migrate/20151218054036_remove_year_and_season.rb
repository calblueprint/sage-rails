class RemoveYearAndSeason < ActiveRecord::Migration
  def change
    remove_index :semesters, [:year, :season]
    remove_column :semesters, :year
    remove_column :semesters, :season
  end
end
