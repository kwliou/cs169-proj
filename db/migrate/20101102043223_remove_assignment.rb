class RemoveAssignment < ActiveRecord::Migration
  def self.up
    drop_table :assignments
  end

  def self.down
  end
end
