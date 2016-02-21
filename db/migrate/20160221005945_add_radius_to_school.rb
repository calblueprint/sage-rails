class AddRadiusToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :radius, :integer, default: 200
  end
end
