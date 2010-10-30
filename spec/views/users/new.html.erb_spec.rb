require 'spec_helper'

describe "/users/new.html.erb" do
  include UsersHelper

  before(:each) do
    assigns[:user] = stub_model(User,
      :new_record? => true,
      :first_name => "value for first_name",
      :last_name => "value for last_name"
    )
  end

  it "renders new user form" do
    render

    response.should have_tag("form[action=?][method=post]", users_path) do
      with_tag("input#user_first_name[name=?]", "user[first_name]")
      with_tag("input#user_last_name[name=?]", "user[last_name]")
    end
  end
end
