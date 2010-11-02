class AddPointsToCourses < ActiveRecord::Migration
  def self.up
    add_column :courses, :points_possible, :decimal
  end

  def self.down
    drop_column :courses, :points_possible
  end
end
