require 'spec_helper'

describe "/departments/show.html.erb" do
  include DepartmentsHelper
  before(:each) do
    assigns[:department] = @department = stub_model(Department,
      :name => "value for name",
      :abbr => "value for abbr"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ abbr/)
  end
end
