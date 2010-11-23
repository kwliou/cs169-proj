require 'spec_helper'

describe Rating do
  before(:each) do
    @valid_attributes = {
      :easiness => 1,
      :interest => 1,
      :work_load => 1,
      :user_id => 1,
      :course_id => ,
      :created_at => Time.now,
      :updated_at => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Rating.create!(@valid_attributes)
  end
end
