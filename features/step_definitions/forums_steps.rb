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
    :password_confirmation => password,
    :email => "dummy@berkeley.edu")
  visit 'login'
  fill_in 'user_session[username]', :with => username
  fill_in 'user_session[password]', :with => password
  click_button 'Login'
end

Given  /^I am subscribed to "([^"]*)" with item "([^"]*)"$/ do |course, item|
  department, number = course.split
  @course = @current_user.courses.create!(
    :department => department,
    :number => number,
    :name => 'Test Class')
  @item = @course.items.create!(
    :name => item,
    :category => 'test')
end

Given  /^I am looking at the posts page$/ do
  visit course_item_posts_path(@course, @item)
end
