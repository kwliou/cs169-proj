require 'spec_helper'

describe Rating do
  before(:each) do
  @user=User.create!(
  :first_name => "value for first_name",
      :last_name => "value for last_name",
      :username => "value for username",
      :password => "value for password",
      :password_confirmation => "value for password",
      :email => "email@email.com"
	  )
	@course=Course.create!(
	:department => "value for department",
      :number => "value for number",
      :days => "value for days",
      :term => "value for term",
      :year => 1,
      :description => "value for description",
      :name => "value for name"
	  )
    @valid_attributes = {
      :easiness => 1,
      :interest => 1,
      :work_load => 1,
      :user_id => @user.id,
      :course_id => @course.id
    }
  end

  it "should create a new instance given valid attributes" do
    Rating.create!(@valid_attributes)
  end
  describe "when validating a rating" do
   it "should not allow a rating without easiness" do
     @no_easiness_attributes = {
       :interest => 1,
      :work_load => 1,
      :user_id => @user.id,
      :course_id => @course.id
     }
     @rating = Rating.new(@no_easiness_attributes)
     @rating.should_not be_valid
   end
   end
     describe "when validating a rating" do
   it "should not allow a rating without interest" do
     @no_interest_attributes = {
       :easiness => 1,
      :work_load => 1,
      :user_id => @user.id,
      :course_id => @course.id
     }
     @rating = Rating.new(@no_interest_attributes)
     @rating.should_not be_valid
   end
   end
     describe "when validating a rating" do
   it "should not allow a rating without work load" do
     @no_work_attributes = {
       :interest => 1,
      :easiness => 1,
      :user_id => @user.id,
      :course_id => @course.id
     }
     @rating = Rating.new(@no_work_attributes)
     @rating.should_not be_valid
   end
   end
     describe "when validating a rating" do
   it "should not allow a rating without user" do
     @no_user_attributes = {
      :easiness => 1,
      :interest => 1,
      :work_load => 1,
      :course_id => @course.id
     }
     @rating = Rating.new(@no_user_attributes)
     @rating.should_not be_valid
   end
   end
   describe "when validating a rating" do
   it "should not allow a rating without course" do
     @no_course_attributes = {
      :easiness => 1,
      :interest => 1,
      :work_load => 1,
      :user_id => @user.id
     }
     @rating = Rating.new(@no_course_attributes)
     @rating.should_not be_valid
   end
   end
   describe "when validating a rating" do
   it "the same user should not be able to make 2 ratings" do
     @attributes = {
      :easiness => 2,
      :interest => 2,
      :work_load => 2,
      :user_id => @user.id,
	  :course_id=>@course.id
     }
     @rating = Rating.create!(@attributes)
	 @rating2=Rating.new(@valid_attributes)
     @rating2.should_not be_valid
   end
   end
   describe "when validating a rating" do
   it "the same user should be allowed to make the different ratings for different courses" do
   @temp=Course.create!(
	:department => "department",
      :number => "number",
      :days => "days",
      :term => "term",
      :year => 1,
      :description => "description",
      :name => "name"
	  )
     @attributes = {
      :easiness => 2,
      :interest => 2,
      :work_load => 2,
      :user_id => @user.id,
	  :course_id=>@temp.id
     }
     @rating = Rating.create!(@attributes)
	 @rating2=Rating.new(@valid_attributes)
     @rating2.should be_valid
   end
   end
   describe "when validating a rating" do
   it "the different users should be allowed to rate the same course" do
   @temp=User.create!(
  :first_name => "first_name",
      :last_name => "last_name",
      :username => "username",
      :password => "password",
      :password_confirmation => "password",
      :email => "email@email2.com"
	  )
     @attributes = {
      :easiness => 2,
      :interest => 2,
      :work_load => 2,
      :user_id => @temp.id,
	  :course_id=>@course.id
     }
     @rating = Rating.create!(@attributes)
	 @rating2=Rating.new(@valid_attributes)
     @rating2.should be_valid
   end
   end
   describe "when returning the total easiness ratings" do
   it "should generate the correct sum" do
   @temp_course=mock(:course)
   @rateing0=mock(:rating)
   @rating1=mock(:rating)
   @rating2=mock(:rating)
   @rating0.stub!(:easiness).and_return(1)
   @rating1.stub!(:easiness).and_return(1)
   @rating2.stub!(:easiness).and_return(1)
   @temp.stub!(:ratings).and_return([@rating0, @rating1, @rating2])
   Rating.total_e(@temp).should ==3
   end
   end
   describe "when returning the total interest ratings" do
   it "should generate the correct sum" do
   @temp_course=mock(:course)
   @rateing0=mock(:rating)
   @rating1=mock(:rating)
   @rating2=mock(:rating)
   @rating0.stub!(:interest).and_return(1)
   @rating1.stub!(:interest).and_return(1)
   @rating2.stub!(:interest).and_return(1)
   @temp.stub!(:ratings).and_return([@rating0, @rating1, @rating2])
   Rating.total_i(@temp).should ==3
   end
   end
   describe "when returning the total easiness ratings" do
   it "should generate the correct sum" do
   @temp_course=mock(:course)
   @rateing0=mock(:rating)
   @rating1=mock(:rating)
   @rating2=mock(:rating)
   @rating0.stub!(:work_load).and_return(1)
   @rating1.stub!(:work_load).and_return(1)
   @rating2.stub!(:work_load).and_return(1)
   @temp.stub!(:ratings).and_return([@rating0, @rating1, @rating2])
   Rating.total_w(@temp).should ==3
   end
   end
   describe "when easiness==1" do
   it "should generate the string WTF? (1/5)" do
   @rating=Rating.new(@valid_attributes)
   @rating.to_s_e(@rating.easiness).should =="WTF? (1/5)"
   end
   end
   describe "when easiness==2" do
   it "should generate the string prerequisite: IQ must be over 180 (2/5)" do
   @rating=Rating.new(@valid_attributes)
   @rating.easiness=2
   @rating.to_s_e(@rating.easiness).should =="prerequisite: IQ must be over 180 (2/5)"
   end
   end
   describe "when easiness==3" do
   it "should generate the string eh...can't complain (3/5)" do
   @rating=Rating.new(@valid_attributes)
   @rating.easiness=3
   @rating.to_s_e(@rating.easiness).should =="eh...can't complain (3/5)"
   end
   end
   describe "when easiness==4" do
   it "should generate the string GPA booster (4/5)" do
   @rating=Rating.new(@valid_attributes)
   @rating.easiness=4
   @rating.to_s_e(@rating.easiness).should =="GPA booster (4/5)"
   end
   end
   describe "when easiness==5" do
   it "should generate the string I swear this is elementary school material (5/5)" do
   @rating=Rating.new(@valid_attributes)
   @rating.easiness=5
   @rating.to_s_e(@rating.easiness).should =="I swear this is elementary school material (5/5)"
   end
   end
   describe "when interest==1" do
   it "should generate the string World's greatest treatement for Insomnia! (1/5)" do
   @rating=Rating.new(@valid_attributes)
   @rating.to_s_i(@rating.interest).should =="World's greatest treatement for Insomnia! (1/5)"
   end
   end
   describe "when interest==2" do
   it "should generate the string Zzz...Zzz... (2/5)" do
   @rating=Rating.new(@valid_attributes)
   @rating.interest=2
   @rating.to_s_i(@rating.interest).should =="Zzz...Zzz... (2/5)"
   end
   end
   describe "when interest==3" do
   it "should generate the string eh...can't complain (3/5)" do
   @rating=Rating.new(@valid_attributes)
   @rating.interest=3
   @rating.to_s_i(@rating.interest).should =="eh...can't complain (3/5)"
   end
   end
   describe "when interest==4" do
   it "should generate the string I took the course 3 times!!! (4/5)" do
   @rating=Rating.new(@valid_attributes)
   @rating.interest=4
   @rating.to_s_i(@rating.interest).should =="I took the course 3 times!!! (4/5)"
   end
   end
   describe "when interest==5" do
   it "should generate the string I cried each time class was over (5/5)" do
   @rating=Rating.new(@valid_attributes)
   @rating.interest=5
   @rating.to_s_i(@rating.interest).should =="I cried each time class was over (5/5)"
   end
   end
   describe "when work_load==1" do
   it "should generate the string my therapist says I'm scarred for life (1/5)" do
   @rating=Rating.new(@valid_attributes)
   @rating.to_s_w(@rating.work_load).should =="my therapist says I'm scarred for life (1/5)"
   end
   end
   describe "when work_load==2" do
   it "should generate the string sleep is for losers (2/5)" do
   @rating=Rating.new(@valid_attributes)
   @rating.work_load=2
   @rating.to_s_w(@rating.work_load).should =="sleep is for losers (2/5)"
   end
   end
   describe "when work_load==3" do
   it "should generate the string eh...can't complain (3/5)" do
   @rating=Rating.new(@valid_attributes)
   @rating.work_load=3
   @rating.to_s_w(@rating.work_load).should =="eh...can't complain (3/5)"
   end
   end
   describe "when work_load==4" do
   it "should generate the string for lazy students only!!! (4/5)" do
   @rating=Rating.new(@valid_attributes)
   @rating.work_load=4
   @rating.to_s_w(@rating.work_load).should =="for lazy students only!!! (4/5)"
   end
   end
   describe "when work_load==5" do
   it "should generate the string a semester long vacation (5/5)" do
   @rating=Rating.new(@valid_attributes)
   @rating.work_load=5
   @rating.to_s_w(@rating.work_load).should =="a semester long vacation (5/5)"
   end
   end
   
end
