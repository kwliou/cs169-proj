class Course < ActiveRecord::Base
  include ApplicationHelper
  has_many :items
  has_many :blurbs
  has_and_belongs_to_many :users
 has_many :ratings, :dependent=>:destroy
  validates_presence_of :department, :name, :number
  validates_uniqueness_of :name, :number, :scope => :department, :case_sensitive => false

  before_save { |course| course.department = course.department.titleizev2 }

  @@abbr = { # NOTE: department names might have funny capitalizing so hard to automate
    "Computer Science" => "compsci",
    "Anthropology" => "anthro",
    "Gender and Women's Studies" => "gws",
    "Aerospace Studies (Air Force ROTC)" => "aerospc",
    "Math" => "math",
    "CS" => "cs"
  }
  def Course.find_by_param(param)
      dept, number = param.split('_')
      department = Course.unabbr(dept)
      Course.find_by_department_and_number(department, number)
  end
  def Course.unabbr(abbr)
    @@abbr.index(abbr.downcase) || abbr.downcase.titleizev2
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
  def e_rating
  if (raters==0)
  return "Someone needs to rate this course!"
  end
  rating=(Rating.total_e(self))/raters
  rating_s=rating.to_s
  if (rating<1.5)
  return "WTF? (" << rating_s <<"/5)"
  end
  if (rating<2.5)
  return "prerequisite: IQ must be over 180 (" << rating_s <<"/5)"
  end
  if (rating<3.5)
  return "eh...can't complain (" << rating_s <<"/5)"
  end
  if (rating<4.5)
  return "GPA booster (" << rating_s <<"/5)"
  end
  else return "I swear this is elementary school material (" << rating_s <<"/5)"
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
  if (rating<1.5)
  return "World's greatest treatement for Insomnia! (" << rating_s <<"/5)"
  end
  if (rating<2.5)
  return "Zzz...Zzz... (" << rating_s <<"/5)"
  end
  if (rating<3.5)
  return "eh...can't complain (" << rating_s <<"/5)"
  end
  if (rating<4.5)
  return "I took the course 3 times!!! (" << rating_s <<"/5)"
  end
  else return "I cried each time class was over (" << rating_s <<"/5)"
  end
  
  def w_rating
  if (raters==0)
  return "Someone needs to rate this course!"
  end
  rating=Rating.total_w(self)/raters
  rating_s=rating.to_s
  if (rating<1.5)
  return "my therapist says I'm scarred for life (" << rating_s <<"/5)"
  end
  if (rating<2.5)
  return "sleep is for losers (" << rating_s <<"/5)"
  end
  if (rating<3.5)
  return "eh...can't complain (" << rating_s <<"/5)"
  end
  if (rating<4.5)
  return "for lazy students only!!! (" << rating_s <<"/5)"
  end
  else return "a semester long vacation (" << rating_s <<"/5)"
  end
  
  def full_name
  return self.department<< "	" << self.number
  end
end