require 'spec_helper'

describe "/users/show.html.erb" do
  include UsersHelper
  before(:each) do
    assigns[:user] = @user = stub_model(User,
      :first_name => "value for first_name",
      :last_name => "value for last_name"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ first_name/)
    response.should have_text(/value\ for\ last_name/)
  end
end
