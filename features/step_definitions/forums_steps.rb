Before do
  include Authlogic::TestCase
  activate_authlogic
end

Given  /^I am "([^"]*)" logged in with "([^"]*)" and "([^"]*)"$/ do |name, username, password|
  first, last = name.split
  @current_user = User.create!(
    :first_name => first,
    :last_name => last,
    :username => username,
    :password => password,
    :password_confirmation => "password",
    :email => "dummy@berkeley.edu")
  visit "login"
  fill_in "user_session[username]", :with => "username"
  fill_in "user_session[password]", :with => "password"
  click_button "Login"
end

When /^I visit the posts page$/ do
  visit user_posts_path(@current_user)
end