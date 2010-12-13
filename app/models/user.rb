class User < ActiveRecord::Base
  acts_as_authentic
  has_and_belongs_to_many :courses
  has_many :posts
  has_many :grades
  has_many :ratings
  has_many :iratings
  
  def to_s
    username
  end
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def fb_url
    return "http://www.facebook.com/profile.php?id=#{self.fb_id}"
  end
  
  def to_param
    username
  end
  
  def rated_course(course)
  	course.ratings.find_by_user_id(self.id)
	end
	
  def rated_item(item)
  	item.iratings.find_by_user_id(self.id)
	end
	
	def items_with_grades(course)
    items = course.items
	  grades = self.grades.reject { |g| g.item.course != course }
    item_grades = grades.collect { |g| [g, g.item] }
    result = []
      
    items.each do |item|
      item_grade = nil
      grades.each do |g|
        if g.item == item
          item_grade = g
        end
      end
      result << [item_grade, item]
    end

    return result
	end

	def performance_dates(course)
    grades = self.grades.sort { |a, b| a.item.due_date <=> b.item.due_date }
    grades = grades.reject { |g| g.item.course != course }
      
	  dates = grades.collect { |g| g.item.due_date.strftime('%m/%d') }
	  
    return dates
	end
	
	def User.class_performance(course)
    user_performances = []
	  course.users.each { |u|
      user_performances << u.performance(course)
	  }

	  # Start with all zeroes for overall averages
	  class_performance = []
	  if user_performances.length < 1
	    return []
	  end
	  for n in 0..user_performances[0].length - 1 do
      class_performance << 0
	  end
	  result = []
    class_performance.each_with_index { |p, i|
       total = 0.0
       user_performances.each { |user_perf|
         total += user_perf[i] || 0.0
       }
       result << format("%.2f", total / user_performances.length).to_f
	  }
	  
	  debugger
	  return result
	end
	
	def performance(course)
    grades = self.grades.sort { |a, b| a.item.due_date <=> b.item.due_date }
	  grades = grades.reject { |g| g.item.course != course }
	  # get all grades
	  # calculate performance up to each of these grades' due date	  
	  averages = []
	  grades.each { |g|
	      pct = (g.points_received * 100) / g.item.points
        total_pct = pct
	      averages.each { |a|
	        total_pct += a
	      }
	      averages << format("%.2f", (total_pct / (averages.length + 1))).to_f
	  }
	  
	  return averages
	  
	end

end
