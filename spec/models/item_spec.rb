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

  it "should create a new instance given valid attributes" do
    Item.create!(@valid_attributes)
  end
end
