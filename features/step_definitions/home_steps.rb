Given /^I have a course named (.+)$/  do |name|
	@user_course=@current_user.courses.create!(:name=> name)
	@course=@user_course
	@course.save
  end


