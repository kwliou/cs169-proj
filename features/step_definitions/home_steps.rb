
Given /^I am subscribed to "([^"]*)"$/ do |course|
  department, number = course.split
  @course = @current_user.courses.create!(
    :department => department,
    :number => number,
    :name => 'Test Class')
end