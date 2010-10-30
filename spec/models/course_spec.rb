require 'spec_helper'

describe Course do
  before(:each) do
    @valid_attributes = {
      :department => "value for department",
      :number => "value for number",
      :days => "value for days",
      :term => "value for term",
      :year => 1,
      :description => "value for description",
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    Course.create!(@valid_attributes)
  end
end
