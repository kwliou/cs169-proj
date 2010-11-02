class Course < ActiveRecord::Base
  has_many :items
  has_many :blurbs
end
