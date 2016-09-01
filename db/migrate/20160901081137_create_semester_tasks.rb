class CreateSemesterTasks < ActiveRecord::Migration
  def change
    create_table :semester_tasks do |t|
      t.timestamps null: false

      t.boolean :set_active
      t.boolean :increment_week
    end
  end
end
