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
    @valid_item_attributes = {
      :type => "value for type",
      :due_date => Time.now,
      :points => 100,
      :category => "value for category"
    }
    @department = Department.create!(
      :name => "Computer Science", :abbr => "COMPSCI"
    )
    @valid_course_attributes = {
      :department => @department,
      :number => "value for number",
      :days => "value for days",
      :term => "value for term",
      :year => 1,
      :description => "value for description",
      :name => "value for name"
    }
    @course=Course.create!(@valid_course_attributes)

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
     @rating.should == @rating2
   end
   end
   
   def setup_performance(points_arr, max_pts)
     i = Item.new(@valid_item_attributes)
     i.points = max_pts
     i.save
     c = Course.create!(@valid_course_attributes)
     c.items << i
     c.items.length.should == 1
     users = []
     for n in 0..9 do
       u = User.new(@valid_user_attributes)
       u.username = "username#{n}"
       u.email = "email#{n}@email.com"
       u.courses << c
       u.grades << Grade.create!({:points_received => points_arr[n], :item => i, :user => u})
       u.save
       users << u
     end
   end
  
   describe "when calculating a users grade performance" do
     it "should calculate the proper class performance for each day" do
       
     end
     
     it "should return an empty result if the student has no graded items" do
       u = User.create(@valid_user_attributes)
       c = Course.create(@valid_course_attributes)
       u.performance(c).should == []
     end
     
     it "should calculate proper average for each day of the performance graph" do
       u = User.create(@valid_attributes)
       for n in 0..9
         i = Item.new(@valid_item_attributes)
         i.course = @course
         # These are already due
         i.due_date = Time.now - 60*60*24*(n + 1)
         i.save
         u.grades << Grade.create!({:points_received => 10, :item => i, :user => u})
         u.save
       end
       perf = u.performance(@course)
       # We should have the same average every day
       for n in 0..9
         perf[n].should == 10.0
       end
       u2 = User.new(@valid_attributes)
       u2.email = "whatever@foo.com"
       u2.username = "some_username"
       u2.save
       atts = @valid_course_attribute
       c = Course.create!(
         :department => @department,
         :number => "213",
         :days => "value for days",
         :term => "value for term",
         :year => 1,
         :description => "another value for description",
         :name => "course name!"
       )
       for n in 0..9
         i = Item.new(@valid_item_attributes)
         i.course = c
         # These are already due as well
         i.due_date = Time.now - 60*60*24*(n + 1)
         i.save
         u2.grades << Grade.create!({:points_received => n * 10, :item => i, :user => u2})
         u2.save
       end
       u2.grades.length.should == 10
       perf = u2.performance(c)
       perf.length.should == 10
       perf[0].should == 90.0
       perf[1].should == 85.0
       perf[2].should == 81.67
       perf[3].should == 79.17
       perf[4].should == 77.17
       perf[5].should == 75.5
       perf[6].should == 74.07
       perf[7].should == 72.82
       perf[8].should == 71.71
       perf[9].should == 70.71
     end
   end
  
end
