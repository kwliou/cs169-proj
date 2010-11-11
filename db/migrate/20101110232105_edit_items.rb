class EditItems < ActiveRecord::Migration
  def self.up
    add_column :items, :name, :string
    change_column :items, :description, :text
    rename_column :items, :type, :category
  end

  def self.down
    remove_column :items, :name
    change_column :items, :description, :string
    rename_column :items, :category, :type
  end
end
