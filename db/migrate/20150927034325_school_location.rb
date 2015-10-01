class SchoolLocation < ActiveRecord::Migration
  def change
    add_column :schools, :lat, :decimal, precision: 10, scale: 7, default: 0.0
    add_column :schools, :lng, :decimal, precision: 10, scale: 7, default: 0.0
  end
end
