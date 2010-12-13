class AddUserIdToIratings < ActiveRecord::Migration
  def self.up
    add_column :iratings, :user_id, :integer
  end

  def self.down
    remove_column :iratings, :user_id
  end
end
