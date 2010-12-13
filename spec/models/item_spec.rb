require 'spec_helper'

describe Item do
  before(:each) do
    @valid_item_attributes = {
      :type => "value for type",
      :due_date => Time.now,
      :points => 100,
      :category => "value for category"
    }
    @valid_course_attributes = {
      :department => Department.create!(:name => "Computer Science", :abbr => "COMPSCI"),
      :number => "169",
      :days => "smTwTfs",
      :term => "Fall",
      :year => 2010,
      :description => "This is a description of software engineering.",
      :name => "Software Engineering"
    }
    @valid_user_attributes = {
      :first_name => "value for first_name",
      :last_name => "value for last_name",
      :username => "value for username",
      :password => "value for password",
      :password_confirmation => "value for password",
      :email => "email@email.com"
    }
  end

  it "should return the proper due date for a given assignemtn" do
    
  end
  
  describe "histograms" do
    it "should create a new instance given valid attributes" do
      Item.create!(@valid_item_attributes)
    end
    
    it "should return an empty result when no histogram data is found" do
      i = Item.create!(@valid_item_attributes)
      i.histogram.should == {:mean => 0.0, :std_dev => 0.0, :title => '', :points => []}
    end
    
    def setup_const_histogram_data(points)
      i = Item.new(@valid_item_attributes)
      i.points = points
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
        u.grades << Grade.create!({:points_received => points, :item => i, :user => u})
        u.save
        users << u
      end
      
      return i.histogram
    end
    
    def setup_histogram_data(points_arr, max_pts)
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
      
      return i.histogram
    end
    
    it "should return the proper point ranges for a given item" do
      histogram = setup_const_histogram_data(100)
      histogram[:mean].should == "100.00"
      histogram[:std_dev].should == "0.00"
      
      # We should get 15 buckets for any score
      histogram[:points].length.should <= 16
        
      histogram = setup_const_histogram_data(9)
      histogram[:mean].should == "9.00"
      histogram[:std_dev].should == "0.00"
      
      histogram[:points].length.should <= 16
        
      histogram = setup_const_histogram_data(1)
      histogram[:mean].should == "1.00"
      histogram[:std_dev].should == "0.00"
      
      histogram[:points].length.should <= 16
        
      histogram = setup_const_histogram_data(1000)
      histogram[:mean].should == "1000.00"
      histogram[:std_dev].should == "0.00"
      
      histogram[:points].length.should <= 16        
    end
    
    it "should return the proper mean for a given item" do
      scores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      histogram = setup_histogram_data(scores, 10)
      histogram[:mean].should == "0.00"
        
      scores = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
      histogram = setup_histogram_data(scores, 10)
      histogram[:mean].should == "10.00"
        
      scores = [100, 10, 56.3, 28.9, 84.9, 0, 71.63, 89.01, 100, 92.35]
      histogram = setup_histogram_data(scores, 100)
      histogram[:mean].should == "63.31"
        
      scores = [0, 0, 0, 0, 48.3, 0, 0, 0, 0, 0]
      histogram = setup_histogram_data(scores, 50)
      histogram[:mean].should == "4.83"
       
      scores = [0.54, 0.93, 0.78, 0.94, 0.32, 0.73, 0.99, 0.12, 0.65, 0.87]
      histogram = setup_histogram_data(scores, 1)
      histogram[:mean].should == "0.69"
    end
    
    it "should return the proper std. dev for a given item" do
      scores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      histogram = setup_histogram_data(scores, 10)
      histogram[:std_dev].should == "0.00"
        
      scores = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
      histogram = setup_histogram_data(scores, 10)
      histogram[:std_dev].should == "0.00"
        
      scores = [100, 10, 56.3, 28.9, 84.9, 0, 71.63, 89.01, 100, 92.35]
      histogram = setup_histogram_data(scores, 100)
      histogram[:std_dev].should == "35.80"
        
      scores = [0, 0, 0, 0, 48.3, 0, 0, 0, 0, 0]
      histogram = setup_histogram_data(scores, 50)
      histogram[:std_dev].should == "14.49"
       
      scores = [0.54, 0.93, 0.78, 0.94, 0.32, 0.73, 0.99, 0.12, 0.65, 0.87]
      histogram = setup_histogram_data(scores, 1)
      histogram[:std_dev].should == "0.27"
    end
    
    it "should return the proper frequencies for a given item" do
      scores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      histogram = setup_histogram_data(scores, 10)
      histogram[:points][0][:freq].should == 10
        
      points = histogram[:points][1,histogram[:points].length - 1]
      # The only frequency > 1 is for the range including 0
      points.each { |p| p[:freq].should == 0 }
        
      scores = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
      histogram = setup_histogram_data(scores, 10)
      histogram[:points][15][:freq].should == 10
        
      scores = [100, 10, 56.3, 28.9, 84.9, 0, 71.63, 89.01, 100, 92.35]
      histogram = setup_histogram_data(scores, 100)
      histogram[:points][0][:freq].should == 1
      histogram[:points][1][:freq].should == 1
      histogram[:points][4][:freq].should == 1
      histogram[:points][8][:freq].should == 1
      histogram[:points][10][:freq].should == 1
      histogram[:points][12][:freq].should == 1   
      histogram[:points][13][:freq].should == 2
      histogram[:points][14][:freq].should == 2   
        
      scores = [0, 0, 0, 0, 48.3, 0, 0, 0, 0, 0]
      histogram = setup_histogram_data(scores, 50)
      histogram[:points][14][:freq].should == 1
      histogram[:points][0][:freq].should == 9
      histogram[:points][1, histogram[:points].length - 2].each { 
        |p| p[:freq].should == 0 
      }
        
      scores = [0.54, 0.93, 0.78, 0.94, 0.32, 0.73, 0.99, 0.12, 0.65, 0.87]
      histogram = setup_histogram_data(scores, 1)
      histogram[:points][0][:freq].should == 0
      histogram[:points][1][:freq].should == 1
      histogram[:points][4][:freq].should == 1
      histogram[:points][8][:freq].should == 1
      histogram[:points][9][:freq].should == 1
      histogram[:points][10][:freq].should == 1   
      histogram[:points][11][:freq].should == 1
      histogram[:points][13][:freq].should == 2
      histogram[:points][14][:freq].should == 2  
    end
    
  end
end
