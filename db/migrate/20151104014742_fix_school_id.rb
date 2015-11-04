class FixSchoolId < ActiveRecord::Migration
  def change
    change_column :announcements, :school_id, :integer, null: true
  end
end
