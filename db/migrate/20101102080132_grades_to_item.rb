class GradesToItem < ActiveRecord::Migration
  def self.up
    remove_column :items, :grade_id
    add_column :grades, :item_id, :integer
  end

  def self.down
    add_column :items, :grade_id, :integer
    remove_column :grades, :item_id
  end
end
