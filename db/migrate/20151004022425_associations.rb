class Associations < ActiveRecord::Migration
  def change
    add_column :users, :school_id, :integer, default: 0
  end
end
