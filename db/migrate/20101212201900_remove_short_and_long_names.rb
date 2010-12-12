class RemoveShortAndLongNames < ActiveRecord::Migration
  def self.up
    remove_column :courses, :short_title
    remove_column :courses, :long_title
    remove_column :courses, :title
  end

  def self.down
    add_column :courses, :short_title, :string
    add_column :courses, :long_title, :string
    add_column :courses, :title, :string
  end
end
