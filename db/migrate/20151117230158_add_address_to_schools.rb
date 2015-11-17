class AddAddressToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :address, :string
  end
end
