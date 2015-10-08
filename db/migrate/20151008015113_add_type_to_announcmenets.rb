class AddTypeToAnnouncmenets < ActiveRecord::Migration
  def change
    add_column :announcements, :category, :integer
  end
end
