class AddForeignKeys < ActiveRecord::Migration
  def self.up
    add_column :items, :course_id, :integer
    add_column :blurbs, :course_id, :integer
    add_column :grades, :user_id, :integer
  end

  def self.down
    remove_column :items, :course_id
    remove_column :blurbs, :course_id
    remove_column :grades, :user_id
  end
end
