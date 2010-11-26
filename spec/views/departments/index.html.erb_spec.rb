require 'spec_helper'

describe "/departments/index.html.erb" do
  include DepartmentsHelper

  before(:each) do
    assigns[:departments] = [
      stub_model(Department,
        :name => "value for name",
        :abbr => "value for abbr"
      ),
      stub_model(Department,
        :name => "value for name",
        :abbr => "value for abbr"
      )
    ]
  end

  it "renders a list of departments" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for abbr".to_s, 2)
  end
end
