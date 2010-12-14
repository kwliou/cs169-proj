
Given /^I am subscribed to "([^"]*)"$/ do |course|
  department, number = course.split
	@department = Department.create!(:name => 'math', :abbr => 'math')
  @course = @current_user.courses.create!(
    :department => @department,
    :number => number,
    :name => 'Test Class',
		:term => 'Fall')
end
