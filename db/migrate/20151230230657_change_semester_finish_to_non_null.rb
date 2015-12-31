class ChangeSemesterFinishToNonNull < ActiveRecord::Migration
  def change
    change_column :semesters, :finish, :datetime
  end
end
