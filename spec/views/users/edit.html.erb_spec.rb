require 'spec_helper'

describe "/users/edit.html.erb" do
  include UsersHelper

  before(:each) do
    assigns[:user] = @user = stub_model(User,
      :new_record? => false,
      :first_name => "value for first_name",
      :last_name => "value for last_name"
    )
  end

  it "renders the edit user form" do
    render

    response.should have_tag("form[action=#{user_path(@user)}][method=post]") do
      with_tag('input#user_first_name[name=?]', "user[first_name]")
      with_tag('input#user_last_name[name=?]', "user[last_name]")
    end
  end
end
