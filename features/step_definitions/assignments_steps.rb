Before do
  include Authlogic::TestCase
  activate_authlogic
  @current_user = User.create!(
    :first_name => "first",
    :last_name => "last",
    :username => "usernameasgn",
    :password => "password",
    :password_confirmation => "password",
    :email => "dummyasgn@berkeley.edu")
  visit "login"
  fill_in "user_session[username]", :with => "usernameasgn"
  fill_in "user_session[password]", :with => "password"
  click_button "Login"
end

Given /^I am a student of the "([A-Za-z ]*) (\d+)" course$/ do |course_name, course_number|
  @new_course = @current_user.courses.create!(
		:department => course_name,
		:number => course_number)
end

When /^I click on the assignments\+projects link on the "([^"]*)" course page$/ do |course|
	visit root_path
	response.should contain(course.to_s)
  click_link course
	response.should contain("Assignments")
	click_link "Assignments/Projects"
end

Then /^I am directed to the Student's version of the "([^"]*)" assignemnts\+projects page$/ do |arg1|
  response.should contain("Due date")
	response.should contain("Assignments")
end

When /^I click on the exams\+quizzes link on the "([^"]*)" course page$/ do |course|
  visit root_path
	response.should contain(course.to_s)
  click_link course
	response.should contain("Exams")
	click_link "Exams/Quizzes"
end

Then /^I am directed to the Student's version of the "([^"]*)" exams\+quizzes page$/ do |arg1|
  response.should contain("Due date")
	#current_path = URI.parse(current_url).path
  #if current_path.respond_to? :should
  #  current_path.should == item_path(@new_course.id)
  #else
  #  assert_equal item_path(@new_course.id), current_path
  #end
end

Given /^my grade for hw(\d+) is (\d+)\/(\d+)$/ do |hw, points, outof|
	@new_course = Course.create!(:department => "Computer Science", :number => "169")
	@current_user.courses << @new_course
	@new_course.users << @current_user
  @assignment = @new_course.items.create(:type => "hw"+hw.to_s, 
																				:points => points.to_s+"/"+outof.to_s,
																				:weight => "5")
end

When /^I visit the assignments\+projects page$/ do
  visit root_path

	click_link "Computer Science 169"
	click_link "Assignments/Projects"
end

Then /^I will see my grade for hw(\d+) is (\d+)\/(\d+)$/ do |arg1, arg2, arg3|
  response.should contain(arg2.to_s)
end

Given /^hw(\d+)'s description is "([^"]*)"$/ do |hw, description|
  @new_course = Course.create!(:department => "Computer Science", :number => "169")
	@current_user.courses << @new_course
	@new_course.users << @current_user
  @assignment = @new_course.items.create(:type => "hw"+hw.to_s, 
																				:description => description,
																				:weight => "5")
end

When /^I click on the "([^"]*)" link on the assignments\+projects page$/ do |arg1|
  visit root_path
	click_link "Computer Science 169"
	click_link "Assignments/Projects"
	click_link arg1
end

Then /^I should see "([^"]*)" as the description$/ do |arg1|
  response.should contain("5.0")
end



