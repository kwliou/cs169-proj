class Course < ActiveRecord::Base
  include ApplicationHelper
  has_many :items
  has_many :blurbs
  has_and_belongs_to_many :users
  has_many :ratings, :dependent=>:destroy
  belongs_to :department
  validates_presence_of :department_id, :name, :number
  validates_uniqueness_of :name, :number, :scope => :department_id, :case_sensitive => false

  #before_save { |course| course.department = course.department.titleizev2 }

  @@abbr = { # NOTE: department names might have funny capitalizing so hard to automate
    "Computer Science" => "compsci",
    "Anthropology" => "anthro",
    "Gender and Women's Studies" => "gws",
    "Aerospace Studies (Air Force ROTC)" => "aerospc",
    "Math" => "math"
  }

  def department_name
    self.department.name
  end
  
  def Course.find_by_param(param)
      dept, number = param.split('_')
      #Course.find_by_number_and_department_id(number, Department.find_by_abbr(dept).id)
      Department.find_by_abbr(dept).courses.find_by_number(number)
  end
  
  def Course.year_limits
    2010.upto(2015)
  end

  def dept
    Department.find(department_id).abbr
    #(@@abbr[department] || department).upcase
  end
  
  def abbr
    "#{dept} #{number}"
  end
  
  def to_param
    "#{dept}_#{number}"
  end
  
  def e_rating
    if (raters == 0)
    return "Someone needs to rate this course!"
  end
  rating=(Rating.total_e(self))/raters
  rating_s=rating.to_s
  case rating
  when 0..1.5
  return "WTF? (" << rating_s <<"/5)"
  when 1.5..2.5
  return "prerequisite: IQ must be over 180 (" << rating_s <<"/5)"
  when 2.5..3.5
  return "eh...can't complain (" << rating_s <<"/5)"
  when 3.5..4.5
  return "GPA booster (" << rating_s <<"/5)"
  when 4.5..5
  return "I swear this is elementary school material (" << rating_s <<"/5)"
  end
  end
  
  def raters
	self.ratings.count
  end
  def i_rating
  if (raters==0)
  return "Someone needs to rate this course!"
  end
  rating=Rating.total_i(self)/raters
  rating_s=rating.to_s
  case rating
  when 0..1.5
  return "World's greatest treatement for Insomnia! (" << rating_s <<"/5)"
  when 1.5..2.5
  return "Zzz...Zzz... (" << rating_s <<"/5)"
  when 2.5..3.5
  return "eh...can't complain (" << rating_s <<"/5)"
  when 3.5..4.5
  return "I took the course 3 times!!! (" << rating_s <<"/5)"
  when 4.5..5
  return "I cried each time class was over (" << rating_s <<"/5)"
  end
  end
  
  def w_rating
  if (raters==0)
  return "Someone needs to rate this course!"
  end
  rating=Rating.total_w(self)/raters
  rating_s=rating.to_s
  case rating
  when 0..1.5
  return "my therapist says I'm scarred for life (" << rating_s <<"/5)"
  when 1.5..2.5
  return "sleep is for losers (" << rating_s <<"/5)"
  when 2.5..3.5
  return "eh...can't complain (" << rating_s <<"/5)"
  when 3.5..4.5
  return "for lazy students only!!! (" << rating_s <<"/5)"
  when 4.5..5
  return "a semester long vacation (" << rating_s <<"/5)"
  end
  end
  
  def full_name
  return self.department<< "	" << self.number
  end
end