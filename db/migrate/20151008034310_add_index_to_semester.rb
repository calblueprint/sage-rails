class AddIndexToSemester < ActiveRecord::Migration
  def change
    add_index :semesters, [:year, :season], unique: true
  end
end
