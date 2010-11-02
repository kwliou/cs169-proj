class Post < ActiveRecord::Base
  belongs_to :user #, :foreign_key => "user_username"
  #belongs_to :item
  #has_many :posts
end
