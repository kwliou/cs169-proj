class User < ActiveRecord::Base
  acts_as_authentic
  has_and_belongs_to_many :courses
  has_many :posts
  has_many :grades
  def to_s
    username
  end
  def name
    "#{first_name} #{last_name}"
  end
  def to_param
    username
  end
end
