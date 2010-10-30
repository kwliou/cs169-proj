require 'spec_helper'

describe Post do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :body => "value for body",
      :commented_at => Time.now,
      :tags => "value for tags"
    }
  end

  it "should create a new instance given valid attributes" do
    Post.create!(@valid_attributes)
  end
end
