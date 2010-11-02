class User < ActiveRecord::Base
  acts_as_authentic
  has_many :posts #, :foreign_key => 'username'
  has_many :courses
  has_many :grades
end
