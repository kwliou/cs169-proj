class AddFkToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :grade_id, :integer
  end

  def self.down
    remove_column :items, :grade_id
  end
end
