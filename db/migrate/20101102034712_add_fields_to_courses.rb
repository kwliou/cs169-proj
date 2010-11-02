class AddFieldsToCourses < ActiveRecord::Migration
  def self.up
    add_column :courses, :title, :string
    add_column :courses, :short_title, :string
  end

  def self.down
    drop_column :courses, :title
    drop_column :courses, :short_title
  end
end
