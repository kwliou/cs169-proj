Feature: User's page includes all of their basic information.

#As a student,
#my user page should have links to all the sites I need to go to
#so that the site is easy for me to navigate

Scenario: Student's name should be on his user page.
	Given I am "John Doe" logged in with "username" and "password"
	When I visit my user page
	Then I should see "John Doe"

Scenario: Student's e-mail address should be on his user page.
	Given I am "John Doe" logged in with "username" and "password"
	And my e-mail address is "johndoe@test.com"
	When I visit my user page
	Then I should see my e-mail adress

Scenario: Student's courses from previous semesters should be on his user page.
	Given I am "John Doe" logged in with "username" and "password"
	And I previously took the "CS169" course
	When I visit my user page
	Then I should see "CS169" listed
	
	
