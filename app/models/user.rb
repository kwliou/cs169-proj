class User < ActiveRecord::Base
  acts_as_authentic
  #set_primary_key :username
  has_many :posts #, :foreign_key => 'username'
  #has_many :courses
end
