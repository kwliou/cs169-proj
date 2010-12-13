require 'spec_helper'

describe Item do
  before(:each) do
    @valid_attributes = {
      :type => "value for type",
      :due_date => Time.now,
      :points => 1,
      :weight => 1.5,
      :category => "value for category"
    }
  end

  describe "histograms" do
    it "should create a new instance given valid attributes" do
      Item.create!(@valid_attributes)
    end
    
    it "should return an empty result when no histogram data is found" do
      
    end
    
    it "should return the proper point ranges for a given item" do
      
    end
    
    it "should return the proper mean for a given item" do
      
    end
    
    it "should return the proper mean for a given item" do
      
    end
    
    it "should return the proper std. dev for a given item" do
      
    end
    
    it "should return the proper std. dev for a given item" do
      
    end
    
    it "should return the proper frequencies for a given item" do
      
    end
    
    it "should return the proper frequencies for a given item" do
      
    end
    
    it "should return the proper frequencies for a given item" do
      
    end
  end
end
