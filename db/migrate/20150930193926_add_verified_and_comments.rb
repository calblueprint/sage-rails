class AddVerifiedAndComments < ActiveRecord::Migration
  def change
    add_column :check_ins, :verified, :boolean, default: false
    add_column :check_ins, :comment, :text
  end
end
