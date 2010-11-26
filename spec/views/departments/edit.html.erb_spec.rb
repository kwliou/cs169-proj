require 'spec_helper'

describe "/departments/edit.html.erb" do
  include DepartmentsHelper

  before(:each) do
    assigns[:department] = @department = stub_model(Department,
      :new_record? => false,
      :name => "value for name",
      :abbr => "value for abbr"
    )
  end

  it "renders the edit department form" do
    render

    response.should have_tag("form[action=#{department_path(@department)}][method=post]") do
      with_tag('input#department_name[name=?]', "department[name]")
      with_tag('input#department_abbr[name=?]', "department[abbr]")
    end
  end
end
