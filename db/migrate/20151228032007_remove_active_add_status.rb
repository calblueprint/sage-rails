class RemoveActiveAddStatus < ActiveRecord::Migration
  def change
    remove_column :users, :active
    add_column :users, :status, :integer, default: 0
    add_index :users, :status
  end
end
