class AdFbIdAgain < ActiveRecord::Migration
  def self.up
    add_column :users, :fb_id, :integer
  end

  def self.down
    remove_column :users, :fb_id
  end
end
