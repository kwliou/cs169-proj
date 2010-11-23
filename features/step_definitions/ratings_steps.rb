Before do
  include Authlogic::TestCase
  activate_authlogic
end

Given /^I rated all (\d+)$/ do |value|
  @rating = @course.ratings.create!(
  :course_id=>@course.id,
	:user_id=>@current_user.id,
    :easiness => value,
    :interest => value,
    :work_load => value)
end

Given /^someone rated all (\d+)$/ do |value|
	@temp=User.create!(:first_name => "temp",
    :last_name => "temp",
    :username => "username2",
    :password => "password2",
    :password_confirmation => "password2",
    :email => "user@example2.com")
  @rating = @course.ratings.create!(
  :course_id=>@course.id,
	:user_id=>@temp.id,
    :easiness => value,
    :interest => value,
    :work_load => value)
end

Given /^I am looking at the ratings page$/ do
  visit course_ratings_path(@course, @rating)
end
Given /^I am looking at the ratings edit page$/ do
  visit edit_course_rating_path(@course, @rating)
end

Given /^I am making a new rating$/ do
  visit new_course_rating_path(@course)
end


