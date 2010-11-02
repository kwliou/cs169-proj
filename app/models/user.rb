class User < ActiveRecord::Base
  acts_as_authentic
  has_and_belongs_to_many :courses
  has_many :posts
  has_many :grades
end
