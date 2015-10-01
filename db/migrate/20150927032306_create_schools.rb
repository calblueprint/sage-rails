class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.timestamps null: false

      t.string :name, null: false, default: ""
    end
  end
end
