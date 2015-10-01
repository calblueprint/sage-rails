class ChangeEndToFinish < ActiveRecord::Migration
  def change
    rename_column :sessions, :end, :finish
  end
end
