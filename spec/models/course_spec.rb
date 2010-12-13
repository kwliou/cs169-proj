require 'spec_helper'

describe Course do
  before(:each) do
    @valid_department = Department.create!(:name => "Computer Science", :abbr => "COMPSCI")
    @valid_attributes = {
      :department => @valid_department,
      :number => "169",
      :days => "smTwTfs",
      :term => "Fall",
      :year => 2010,
      :description => "This is a description of software engineering.",
      :name => "Software Engineering"
    }
  end

  it "should create a new instance given valid attributes" do
    Course.create!(@valid_attributes)
  end
  
  describe "when validating a course" do
    it "should not allow a course with no name" do
      @no_name = {
        :department => @valid_department,
        :number => "169",
        :days => "smTwTfs",
        :term => "Fall",
        :year => 2010,
        :description => "This is a description of software engineering.",
      }
      @course = Course.new(@no_name)
      @course.should_not be_valid
    end
    
    it "should not allow a course with no number" do
      @no_course_number = {
        :department => @valid_department,
        :days => "smTwTfs",
        :term => "Fall",
        :year => 2010,
        :description => "This is a description of software engineering.",
        :name => "Software Engineering"
      }
      @course = Course.new(@no_course_number)
      @course.should_not be_valid
    end
    
    it "should not allow a course with no department" do
      @no_department = {
        :number => "169",
        :days => "smTwTfs",
        :term => "Fall",
        :year => 2010,
        :description => "This is a description of software engineering.",
        :name => "Software Engineering"
      }    
      @course = Course.new(@no_department)
      @course.should_not be_valid
    end
    
    it "should not allow course names in a department that are not unique" do
      @duplicate_name = {
        :department => @valid_department,
        :number => "170",
        :days => "smTwTfs",
        :term => "Fall",
        :year => 2010,
        :description => "This is a description of software engineering.",
        :name => "Software Engineering"
      }
      Course.create!(@duplicate_name)
    end
    
    it "should not allow course numbers in a department that are not unique" do
      @duplicate_number = {
        :department => @valid_department,
        :number => "169",
        :days => "smTwTfs",
        :term => "Fall",
        :year => 2010,
        :description => "This is a description of software engineering.",
        :name => "Underwater Basket-weaving"
      }
      Course.create!(@duplicate_number)
    end
  end
  
  describe "When checking ratings" do  
    it "should print a message if no one has rated it" do
      @course = Course.new(@valid_attributes)
      @course.e_rating.should match "Someone needs to rate this course!"
      @course.i_rating.should match "Someone needs to rate this course!"
      @course.w_rating.should match "Someone needs to rate this course!"
    end
    
    it "should have 1 rater if 1 person has rated it" do
      @course = Course.new(@valid_attributes)
      @course.ratings.stub!(:count).and_return(1)
      @course.raters.should be 1
    end
    
    it "should print a funny message if it is rated highly" do
      @course = Course.new(@valid_attributes)
      @course.stub!(:raters).and_return(1)
      #@mock_rating = mock_model(Rating, :to_s => "1")
      Rating.stub!(:total_i).and_return(5)
      @course.i_rating.should match "I cried each time class was over"
    end
  end
  
  describe "when printing its information" do
    it "should print its whole name" do
      @course = Course.new(@valid_attributes)
      @course.full_name.should match "Computer Science\t169"
    end
    
    it "should print its abbreviated name" do
      @course = Course.new(@valid_attributes)
      @course.abbr.should match "COMPSCI 169"
    end
  end
end
