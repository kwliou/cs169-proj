require 'spec_helper'

describe "/courses/show.html.erb" do
  include CoursesHelper
  before(:each) do
    assigns[:course] = @course = stub_model(Course,
      :department => "value for department",
      :number => "value for number",
      :days => "value for days",
      :term => "value for term",
      :year => 1,
      :description => "value for description",
      :name => "value for name"
    )
  end

  it "renders attributes in <p>" do
#    render
#    response.should have_text(/value\ for\ department/)
#    response.should have_text(/value\ for\ number/)
#    response.should have_text(/value\ for\ days/)
#    response.should have_text(/value\ for\ term/)
#    response.should have_text(/1/)
#    response.should have_text(/value\ for\ description/)
#    response.should have_text(/value\ for\ name/)
  end
end
