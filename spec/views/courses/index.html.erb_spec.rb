require 'spec_helper'

describe "/courses/index.html.erb" do
  include CoursesHelper

  before(:each) do
    assigns[:courses] = [
      stub_model(Course,
        :department => "value for department",
        :number => "value for number",
        :days => "value for days",
        :term => "value for term",
        :year => 1,
        :description => "value for description",
        :name => "value for name"
      ),
      stub_model(Course,
        :department => "value for department",
        :number => "value for number",
        :days => "value for days",
        :term => "value for term",
        :year => 1,
        :description => "value for description",
        :name => "value for name"
      )
    ]
  end

  it "renders a list of courses" do
    render
    response.should have_tag("tr>td", "value for department".to_s, 2)
    response.should have_tag("tr>td", "value for number".to_s, 2)
    response.should have_tag("tr>td", "value for days".to_s, 2)
    response.should have_tag("tr>td", "value for term".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
