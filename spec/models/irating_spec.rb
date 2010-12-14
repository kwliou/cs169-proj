require 'spec_helper'

describe Irating do
  before(:each) do
    @user=User.create!(
  :first_name => "value for first_name",
      :last_name => "value for last_name",
      :username => "value for username",
      :password => "value for password",
      :password_confirmation => "value for password",
      :email => "email@email.com"
	  )
	  @department=Department.create!(
	  :name=>"name",
	  :abbr=>"abbr"
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
	  @item = Item.create!(
      :type => "value for type",
      :due_date => Time.now,
      :points => 100,
      :category => "value for category"
    )
    @valid_attributes = {
      :easiness => 1,
      :interest => 1,
      :work_load => 1,
      :user_id => @user.id,
      :item_id => @item.id
    }
  end

  it "should create a new instance given valid attributes" do
    Irating.create!(@valid_attributes)
  end
  describe "when validating a rating" do
   it "should not allow a rating without easiness" do
     @no_easiness_attributes = {
       :interest => 1,
      :work_load => 1,
      :user_id => @user.id,
      :item_id => @item.id
     }
     @rating = Irating.new(@no_easiness_attributes)
     @rating.should_not be_valid
   end
   end
     describe "when validating a rating" do
   it "should not allow a rating without interest" do
     @no_interest_attributes = {
       :easiness => 1,
      :work_load => 1,
      :user_id => @user.id,
      :item_id => @item.id
     }
     @rating = Irating.new(@no_interest_attributes)
     @rating.should_not be_valid
   end
   end
     describe "when validating a rating" do
   it "should not allow a rating without work load" do
     @no_work_attributes = {
       :interest => 1,
      :easiness => 1,
      :user_id => @user.id,
      :item_id => @item.id
     }
     @rating = Irating.new(@no_work_attributes)
     @rating.should_not be_valid
   end
   end
     describe "when validating a rating" do
   it "should not allow a rating without user" do
     @no_user_attributes = {
      :easiness => 1,
      :interest => 1,
      :work_load => 1,
      :item_id => @item.id
     }
     @rating = Irating.new(@no_user_attributes)
     @rating.should_not be_valid
   end
   end
   describe "when validating a rating" do
   it "should not allow a rating without item" do
     @no_course_attributes = {
      :easiness => 1,
      :interest => 1,
      :work_load => 1,
      :user_id => @user.id
     }
     @rating = Irating.new(@no_course_attributes)
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
	  :item_id=>@item.id
     }
     @rating = Irating.create!(@attributes)
	 @rating2=Irating.new(@valid_attributes)
     @rating2.should_not be_valid
   end
   end
   describe "when validating a rating" do
   it "the same user should be allowed to make different ratings for different items" do
   @temp=Item.create!(
	:type => "type",
      :due_date => Time.now,
      :points => 100,
      :category => "exam"
	  )
     @attributes = {
      :easiness => 2,
      :interest => 2,
      :work_load => 2,
      :user_id => @user.id,
	  :item_id=>@temp.id
     }
     @rating = Irating.create!(@attributes)
	 @rating2=Irating.new(@valid_attributes)
     @rating2.should be_valid
   end
   end
   describe "when validating a rating" do
   it "the different users should be allowed to rate the same item" do
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
	  :item_id=>@item.id
     }
     @rating = Irating.create!(@attributes)
	 @rating2=Irating.new(@valid_attributes)
     @rating2.should be_valid
   end
   end
   describe "when returning the total easiness ratings" do
   it "should generate the correct sum" do
   @temp_item=mock(:item)
   @rateing0=mock(:irating)
   @rating1=mock(:irating)
   @rating2=mock(:irating)
   @rating0.stub!(:easiness).and_return(1)
   @rating1.stub!(:easiness).and_return(1)
   @rating2.stub!(:easiness).and_return(1)
   @temp_item.stub!(:iratings).and_return([@rating0, @rating1, @rating2])
   Irating.total_e(@temp_item).should ==3
   end
   end
   describe "when returning the total interest ratings" do
   it "should generate the correct sum" do
   @temp_item=mock(:item)
   @rateing0=mock(:rating)
   @rating1=mock(:rating)
   @rating2=mock(:rating)
   @rating0.stub!(:interest).and_return(1)
   @rating1.stub!(:interest).and_return(1)
   @rating2.stub!(:interest).and_return(1)
   @temp_item.stub!(:iratings).and_return([@rating0, @rating1, @rating2])
   Irating.total_i(@temp_item).should ==3
   end
   end
   describe "when returning the total easiness ratings" do
   it "should generate the correct sum" do
   @temp_item=mock(:item)
   @rateing0=mock(:rating)
   @rating1=mock(:rating)
   @rating2=mock(:rating)
   @rating0.stub!(:work_load).and_return(1)
   @rating1.stub!(:work_load).and_return(1)
   @rating2.stub!(:work_load).and_return(1)
   @temp_item.stub!(:iratings).and_return([@rating0, @rating1, @rating2])
   Irating.total_w(@temp_item).should ==3
   end
   end
   describe "when easiness==1" do
   it "should generate the string WTF? (1/5)" do
   @rating=Irating.new(@valid_attributes)
   Irating.to_s_e(@rating.easiness).should =="WTF? (1/5)"
   end
   end
   describe "when easiness==2" do
   it "should generate the string prerequisite: IQ must be over 180 (2/5)" do
   @rating=Irating.new(@valid_attributes)
   @rating.easiness=2
   Irating.to_s_e(@rating.easiness).should =="prerequisite: IQ must be over 180 (2/5)"
   end
   end
   describe "when easiness==3" do
   it "should generate the string eh...can't complain (3/5)" do
   @rating=Irating.new(@valid_attributes)
   @rating.easiness=3
   Irating.to_s_e(@rating.easiness).should =="eh...can't complain (3/5)"
   end
   end
   describe "when easiness==4" do
   it "should generate the string GPA booster (4/5)" do
   @rating=Irating.new(@valid_attributes)
   @rating.easiness=4
   Irating.to_s_e(@rating.easiness).should =="GPA booster (4/5)"
   end
   end
   describe "when easiness==5" do
   it "should generate the string I swear this is elementary school material (5/5)" do
   @rating=Irating.new(@valid_attributes)
   @rating.easiness=5
   Irating.to_s_e(@rating.easiness).should =="I swear this is elementary school material (5/5)"
   end
   end
   describe "when interest==1" do
   it "should generate the string I felt stupider after finishing (1/5)" do
   @rating=Irating.new(@valid_attributes)
   Irating.to_s_i(@rating.interest).should =="I felt stupider after finishing (1/5)"
   end
   end
   describe "when interest==2" do
   it "should generate the string my brain was in sleep mode the whole time (2/5)" do
   @rating=Irating.new(@valid_attributes)
   @rating.interest=2
   Irating.to_s_i(@rating.interest).should =="my brain was in sleep mode the whole time (2/5)"
   end
   end
   describe "when interest==3" do
   it "should generate the string eh...can't complain (3/5)" do
   @rating=Irating.new(@valid_attributes)
   @rating.interest=3
   Irating.to_s_i(@rating.interest).should =="eh...can't complain (3/5)"
   end
   end
   describe "when interest==4" do
   it "should generate the string After the 10th time of looking over it, I still learned something new (4/5)" do
   @rating=Irating.new(@valid_attributes)
   @rating.interest=4
   Irating.to_s_i(@rating.interest).should =="After the 10th time of looking over it, I still learned something new (4/5)"
   end
   end
   describe "when interest==5" do
   it "should generate the string it uncovers the secrets of the universe!!! (5/5)" do
   @rating=Irating.new(@valid_attributes)
   @rating.interest=5
   Irating.to_s_i(@rating.interest).should =="it uncovers the secrets of the universe!!! (5/5)"
   end
   end
   describe "when work_load==1" do
   it "should generate the string even a time machine can't save you (1/5)" do
   @rating=Irating.new(@valid_attributes)
   Irating.to_s_w(@rating.work_load).should =="even a time machine can't save you (1/5)"
   end
   end
   describe "when work_load==2" do
   it "should generate the string sleep is for losers (2/5)" do
   @rating=Irating.new(@valid_attributes)
   @rating.work_load=2
   Irating.to_s_w(@rating.work_load).should =="sleep is for losers (2/5)"
   end
   end
   describe "when work_load==3" do
   it "should generate the string eh...can't complain (3/5)" do
   @rating=Irating.new(@valid_attributes)
   @rating.work_load=3
   Irating.to_s_w(@rating.work_load).should =="eh...can't complain (3/5)"
   end
   end
   describe "when work_load==4" do
   it "should generate the string definitely not a CS project (4/5)" do
   @rating=Irating.new(@valid_attributes)
   @rating.work_load=4
   Irating.to_s_w(@rating.work_load).should =="definitely not a CS project (4/5)"
   end
   end
   describe "when work_load==5" do
   it "should generate the string I don't remember doing ANY work (5/5)" do
   @rating=Irating.new(@valid_attributes)
   @rating.work_load=5
   Irating.to_s_w(@rating.work_load).should =="I don't remember doing ANY work (5/5)"
   end
   end
   
end
