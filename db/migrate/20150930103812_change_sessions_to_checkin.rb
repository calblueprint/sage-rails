class ChangeSessionsToCheckin < ActiveRecord::Migration
  def change
    rename_table :sessions, :check_ins
  end
end
