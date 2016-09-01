class AddDefaultToSemesterTask < ActiveRecord::Migration
  def change
    change_column :semester_tasks, :set_active, :boolean, default: false
    change_column :semester_tasks, :increment_week, :boolean, default: false
  end
end
