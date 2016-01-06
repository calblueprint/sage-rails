class RemoveYearFromSemesters < ActiveRecord::Migration
  def change
    remove_column :semesters, :year
  end
end
