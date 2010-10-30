require 'spec_helper'

describe "/courses/edit.html.erb" do
  include CoursesHelper

  before(:each) do
    assigns[:course] = @course = stub_model(Course,
      :new_record? => false,
      :department => "value for department",
      :number => "value for number",
      :days => "value for days",
      :term => "value for term",
      :year => 1,
      :description => "value for description",
      :name => "value for name"
    )
  end

  it "renders the edit course form" do
    render

    response.should have_tag("form[action=#{course_path(@course)}][method=post]") do
      with_tag('input#course_department[name=?]', "course[department]")
      with_tag('input#course_number[name=?]', "course[number]")
      with_tag('input#course_days[name=?]', "course[days]")
      with_tag('input#course_term[name=?]', "course[term]")
      with_tag('input#course_year[name=?]', "course[year]")
      with_tag('textarea#course_description[name=?]', "course[description]")
      with_tag('input#course_name[name=?]', "course[name]")
    end
  end
end
