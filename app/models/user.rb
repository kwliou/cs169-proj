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
	

end
