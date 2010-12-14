class Course < ActiveRecord::Base
  include ApplicationHelper
  has_many :items
  has_many :blurbs
  has_and_belongs_to_many :users
  has_many :ratings, :dependent=>:destroy
  belongs_to :department
  validates_presence_of :department_id, :name, :number
  #validates_uniqueness_of :name, :number, :scope => :department_id, :case_sensitive => false

  #before_save { |course| course.department = course.department.titleizev2 }

  @@terms = {
    "FA" => "Fall",
    "WI" => "Winter",
    "SP" => "Spring",
    "SU" => "Summer"
  }

  def pretty_term
    return "#{self.term} #{self.year}"
  end
  
  def get_all_semesters
    courses = Department.find(self.department).courses
    other_sems = []
    courses.each { |c|
      if c.number == self.number
        other_sems << c
      end
    }
    return other_sems
  end
  
  def department_name
    self.department.name
  end
  
  def class_performance
    
  end
  
  
  def Course.find_by_param(param)
      dept, number, term_year = param.split('_')
      term = @@terms[term_year[0, 2]]
      year = ("20" + term_year[2, 4]).to_i
      courses = Department.find_by_abbr(dept).courses
      course = nil
      courses.each { |c|
        if c.number == number && c.term == term && c.year == year
          course = c
        end 
      }
      
      return course
  end
  
  def Course.all_semesters
    semesters = []
    Course.year_limits.each { |year|
      ["Fall", "Winter", "Summer", "Spring"].each { |sem|
        semesters << "#{sem} #{year}"
      }
    }
    return semesters
  end
  
  def Course.year_limits
    2010.upto(2015)
  end

  def dept
    Department.find(department_id).abbr.upcase
  end
  
  def abbr
    "#{dept} #{number}"
  end
  
  def to_param
    "#{dept}_#{number}_#{term.upcase[0, 2]}#{year.to_s[2, 4]}"
  end
  
  def e_rating
    if (raters == 0)
      return "Someone needs to rate this course!"
    end
	  rating=Rating.total_e(self)/raters
    rating_s=rating.to_s
    return Rating.to_s_e(rating)
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
    return Rating.to_s_i(rating)
  end
  
  def w_rating
    if (raters==0)
      return "Someone needs to rate this course!"
    end
    rating=Rating.total_w(self)/raters
    rating_s=rating.to_s
    return Rating.to_s_w(rating)
  end
  
  def full_name
    return self.department.name << "	" << self.number
  end
end
