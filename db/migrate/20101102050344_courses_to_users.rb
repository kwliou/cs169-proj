class CoursesToUsers < ActiveRecord::Migration
  def self.up
    create_table :courses_users, :id => false do |t|
      t.column :user_id, :integer, :null => false
      t.column :course_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :courses_users
  end
end
