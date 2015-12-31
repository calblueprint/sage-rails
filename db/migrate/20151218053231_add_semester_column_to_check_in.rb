class AddSemesterColumnToCheckIn < ActiveRecord::Migration
  def change
    add_column :check_ins, :semester_id, :integer
    add_index :check_ins, :semester_id
  end
end
