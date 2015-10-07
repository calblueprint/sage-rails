class AddDirectorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :director_id, :integer
  end
end
