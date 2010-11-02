class Course < ActiveRecord::Base
  has_many :items
  has_many :blurbs
  has_and_belongs_to_many :users
end