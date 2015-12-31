class ActuallyRemoveConstraintOnSemester < ActiveRecord::Migration
  def change
    change_column_null :semesters, :finish, true
  end
end
