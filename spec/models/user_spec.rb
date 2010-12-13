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
	
    @department = Department.create!(
      :name => "Computer Science", :abbr => "COMPSCI"
    )
    @course=Course.create!(
      :department => @department,
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
   
   describe "when calculating a users grade performance" do
     it "should calculate the proper class performance for each day" do
       
     end
     
     it "should return an empty result if the student has no graded items" do
       
     end
     
     it "should calculate proper average for each day of the performance graph" do
       
     end
     
     it "should have as many data points as the user has grades" do
       
     end
   end
  
end
