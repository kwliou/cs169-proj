class CreateDepartments < ActiveRecord::Migration
  def self.up
    add_column :courses, :department_id, :integer
    remove_column :courses, :department
    create_table :departments do |t|
      t.string :name
      t.string :abbr

      t.timestamps
    end
  end

  def self.down
    drop_table :departments
    remove_column :courses, :department_id
    add_column :courses, :department, :string
  end
end
