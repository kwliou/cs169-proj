class Course < ActiveRecord::Base
  include ApplicationHelper
  has_many :items
  has_many :blurbs
  has_and_belongs_to_many :users

  validates_presence_of :department, :name, :number
  validates_uniqueness_of :name, :number, :scope => :department, :case_sensitive => false

  before_save { |course| course.department = course.department.titleizev2 }

  @@abbr = { # NOTE: department names might have funny capitalizing so hard to automate
    "Computer Science" => "compsci",
    "Anthropology" => "anthro",
    "Gender and Women's Studies" => "gws",
    "Aerospace Studies (Air Force ROTC)" => "aerospc",
    "math" => "Math",
    "MATH" => "Math"
  }
  
  def Course.unabbr(abbr)
    @@abbr[abbr.downcase] || abbr
  end
  def dept
    (@@abbr[department] || department).upcase
  end
  def abbr
    "#{dept} #{number}"
  end
  def to_param
    "#{dept}_#{number}"
  end
end