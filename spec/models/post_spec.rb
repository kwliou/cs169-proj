require 'spec_helper'

describe Post do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :body => "value for body",
      :tags => "tags"
    }
  end

  it "should create a new instance given valid attributes" do
    Post.create!(@valid_attributes)
  end
  it "should allow some html" do
    @post = Post.create!(
      :title => "value for title",
      :body => "<a href=http://refactored.heroku.com>blah</a>",
      :tags => "tags")
    @post.body.index('href').should_not == nil
  end
end
