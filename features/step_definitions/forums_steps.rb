Before do
  include Authlogic::TestCase
  activate_authlogic
end

Given /^I am "([^"]*)" logged in with "([^"]*)" and "([^"]*)"$/ do |name, username, password|
  first, last = name.split
  @current_user = User.create!(
    :first_name => first,
    :last_name => last,
    :username => username,
    :password => password,
    :password_confirmation => password,
    :email => "user@example.com")
  visit 'login'
  fill_in 'user_session[username]', :with => username
  fill_in 'user_session[password]', :with => password
  click_button 'Login'
end

Given /^I am subscribed to "([^"]*)" with item "([^"]*)"$/ do |course, item|
  department, number = course.split
  @course = @current_user.courses.create!(
    :department => department,
    :number => number,
    :name => 'Test Class')
  @item = @course.items.create!(
    :name => item,
    :category => 'Assignment')
end

Given /^I am looking at the posts page$/ do
  visit course_item_posts_path(@course, @item)
end

Given /^I am making a new post$/ do
  visit new_course_item_post_path(@course, @item)
end

Given /^I posted "([^"]*)" with "([^"]*)"$/ do |title, body|
  @post = @item.posts.create!(
    :user_id => @current_user.id,
    :title => title,
    :body => body,
    :tags => 'Test')
end

Given /^"([^"]*)" posted "([^"]*)" with "([^"]*)"$/ do |user, title, body|
  @user = User.create!(
    :first_name => user,
    :last_name => "Dummy",
    :username => user,
    :password => "password",
    :password_confirmation => "password",
    :email => "dummy@example.com")
  @post2 = @item.posts.create!(
    :user_id => @user.id,
    :title => title,
    :body => body,
    :tags => 'Test')
end

Given /^"([^"]*)" replied "([^"]*)" with "([^"]*)"$/ do |user, title, body|
  @user = User.create!(
    :first_name => user,
    :last_name => "Dummy",
    :username => user,
    :password => "password",
    :password_confirmation => "password",
    :email => "dummy@example.com")
  @post2 = @item.posts.create!(
    :user_id => @user.id,
    :title => title,
    :body => body,
    :tags => 'Test')
end

When /^I edit the post with "([^"]*)"$/ do |body|
  @post.body = body
end

When /^I post a reply "([^"]*)" with "([^"]*)"$/ do |title, body|
  visit course_item_post_path(@course, @item, @post2)
  click_link('Reply')
  fill_in('post[title]', :with => title)
  fill_in('post[body]', :with => body)
  fill_in('post[tags]', :with => 'Test')
  click_button('Create')
end

When /^I reply to the reply "([^"]*)" with "([^"]*)"$/ do |title, body|
  visit course_item_post_path(@course, @item, @post2)
  click_link('Reply')
  fill_in('post[title]', :with => title)
  fill_in('post[body]', :with => body)
  fill_in('post[tags]', :with => 'Test')
  click_button('Create')
end
