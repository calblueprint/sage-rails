class ChangeTypeColumn < ActiveRecord::Migration
  def change
    change_column :users, :type, :string
  end
end
