class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.timestamps null: false

      t.datetime :start, null: false
      t.datetime :end, null: false
      t.integer :school_id
      t.integer :user_id
    end

    add_index :sessions, :school_id
    add_index :sessions, :user_id
  end
end
