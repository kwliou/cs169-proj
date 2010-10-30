class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.string :department
      t.string :number
      t.string :days
      t.string :term
      t.integer :year
      t.text :description
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
