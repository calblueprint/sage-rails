class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.timestamps null: false
      t.string :title, null: false, default: ""
      t.text :body, null: false, default: ""
      t.integer :school_id, null: false
      t.integer :user_id, null: false
    end
    add_index :announcements, :school_id
    add_index :announcements, :user_id
  end
end
