class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.datetime :start, null: false
      t.datetime :finish, null: false

      t.timestamps null: false
    end
  end
end
