class RemoveSchoolIdDefault < ActiveRecord::Migration
  def change
    remove_column :users, :school_id, :integer, default: 0
    add_column :users, :school_id, :integer
  end
end
