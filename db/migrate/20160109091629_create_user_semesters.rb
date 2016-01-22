class CreateUserSemesters < ActiveRecord::Migration
  def change
    create_table :user_semesters do |t|
      t.integer :user_id
      t.integer :semester_id
      t.boolean :completed, default: false

      t.timestamps null: false
    end

    add_index :user_semesters, [:user_id, :semester_id], unique: true
  end
end
