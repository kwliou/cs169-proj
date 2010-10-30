class User < ActiveRecord::Base
  acts_as_authentic
  has_many :courses
  has_many :posts
end
