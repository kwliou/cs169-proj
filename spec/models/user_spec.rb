require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
      :first_name => "value for first_name",
      :last_name => "value for last_name",
      :username => "value for username",
      :password => "value for password",
      :password_confirmation => "value for password",
      :email => "email@email.com"
    }
	
	@course=Course.create!(
	:department => "value for department",
      :number => "value for number",
      :days => "value for days",
      :term => "value for term",
      :year => 1,
      :description => "value for description",
      :name => "value for name"
	  )
	  
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
  describe "when looking for a user's rating of a course" do
   it "should return the correct rating" do
   @user=User.create(@valid_attributes)
   @rating=Rating.create!(
	  :easiness => 1,
      :interest => 1,
      :work_load => 1,
      :user_id => @user.id,
      :course_id => @course.id
	  )
     @rating2=@user.rated_course(@course)
     @rating.should ==@rating2
   end
   end
  
end
