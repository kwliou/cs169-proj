class User < ActiveRecord::Base
  acts_as_authentic
  has_and_belongs_to_many :courses
  has_many :posts
  has_many :grades
  has_many :ratings
  
  def to_s
    username
  end
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def to_param
    username
  end
  
  def rated_course(course)
  	course.ratings.find_by_user_id(self.id)
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
	
	def performance
    grades = self.grades.sort { |a, b| a.item.due_date <=> b.item.due_date }
    
    # For each grade, calculate the average grade % up to 
    # the corresponding due date
    i = 1
    data = []
    grades.each do |grade|
      total_pct = 0.0
      grades[0, i].each do |g|
        total_pct += (g.points_received / g.item.points) * 100
      end
      pct = total_pct / i
      data << {:date => grade.item.due_date, :average => pct}
      i += 1
    end
    
    return data
	end

end
