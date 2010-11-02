class AddTitleToBlurbs < ActiveRecord::Migration
  def self.up
    add_column :blurbs, :title, :text
  end

  def self.down
    remove_column :blurbs, :title
  end
end
