class MoveStatusToUserSemester < ActiveRecord::Migration
  def change
    remove_column :users, :status
    add_column :user_semesters, :status, :integer, default: 1
  end
end
