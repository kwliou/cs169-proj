class Item < ActiveRecord::Base
  belongs_to :course
  has_many :blurbs
  has_many :grades
end
