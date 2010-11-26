require 'spec_helper'

describe "/departments/new.html.erb" do
  include DepartmentsHelper

  before(:each) do
    assigns[:department] = stub_model(Department,
      :new_record? => true,
      :name => "value for name",
      :abbr => "value for abbr"
    )
  end

  it "renders new department form" do
    render

    response.should have_tag("form[action=?][method=post]", departments_path) do
      with_tag("input#department_name[name=?]", "department[name]")
      with_tag("input#department_abbr[name=?]", "department[abbr]")
    end
  end
end
