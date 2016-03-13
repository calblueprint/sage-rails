class AddDeviceTypeAndDeviceId < ActiveRecord::Migration
  def change
    add_column :users, :device_type, :integer
    add_column :users, :device_id, :integer
  end
end
