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

Given /^I am subscribed to "([^"]*)"$/ do |course|
  department, number = course.split
  @course = @current_user.courses.create!(
    :department => department,
    :number => number,
    :name => 'Test Class')
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


