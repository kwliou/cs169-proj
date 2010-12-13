require 'spec_helper'

describe "/users/index.html.erb" do
  include UsersHelper

  before(:each) do
    assigns[:users] = [
      stub_model(User,
        :username => "username",
        :first_name => "value for first_name",
        :last_name => "value for last_name"
      ),
      stub_model(User,
        :username => "username2",
        :first_name => "value for first_name2",
        :last_name => "value for last_name2"
      )
    ]
  end

  it "renders a list of users" do
    render
#    response.should have("value for first_name".to_s)
#    response.should have("value for last_name".to_s)
#    response.should have("value for first_name2".to_s)
#    response.should have("value for last_name2".to_s)
  end
end
