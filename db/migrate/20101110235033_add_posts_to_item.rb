class AddPostsToItem < ActiveRecord::Migration
  def self.up
    add_column :posts, :item_id, :integer
  end

  def self.down
    remove_column :posts, :item_id
  end
end
