require 'spec_helper'

describe "/users/index.html.erb" do
  include UsersHelper

  before(:each) do
    assigns[:users] = [
      stub_model(User,
        :first_name => "value for first_name",
        :last_name => "value for last_name"
      ),
      stub_model(User,
        :first_name => "value for first_name",
        :last_name => "value for last_name"
      )
    ]
  end

  it "renders a list of users" do
    render
    response.should have_tag("tr>td", "value for first_name".to_s, 2)
    response.should have_tag("tr>td", "value for last_name".to_s, 2)
  end
end
