class Item < ActiveRecord::Base
  belongs_to :course
  has_many :blurbs
  has_many :grades
  has_many :posts

  def to_param
    name.gsub(' ', '_')
  end
end
