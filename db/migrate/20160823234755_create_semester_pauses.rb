class CreateSemesterPauses < ActiveRecord::Migration
  def change
    create_table :semester_pauses do |t|
      t.timestamps null: false
      t.datetime :date_paused
      t.integer :semester_id
    end
  end
end
