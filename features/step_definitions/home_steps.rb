
Given /^I am subscribed to "([^"]*)"$/ do |course|
  department, number = course.split
  @dept = Department.create!(:name => department, :abbr => department)
  @new_course = @current_user.courses.create!(
	  :department_id => @dept.id,
    :number => number,
    :name => 'Test Class',
    :term => 'Fall',
    :year => 2010)
end
