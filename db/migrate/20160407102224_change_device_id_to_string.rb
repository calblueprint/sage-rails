class ChangeDeviceIdToString < ActiveRecord::Migration
  def change
    change_column :users, :device_id, :string
  end
end
