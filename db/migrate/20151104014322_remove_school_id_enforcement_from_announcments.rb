class RemoveSchoolIdEnforcementFromAnnouncments < ActiveRecord::Migration
  def change
    change_column :announcements, :school_id, :integer
  end
end
