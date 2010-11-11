class Post < ActiveRecord::Base
  belongs_to :user #, :foreign_key => "user_username"
  belongs_to :item
  #has_many :comments, :class_name => 'Post', :through => :replies
end
