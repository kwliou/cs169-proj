
Feature: main homepage is linked to various course pages

#As a student,
#I want to access my course pages from the main homepage
#So that I can view details about my courses

Scenario: student clicks on the link to his/her course
	Given I am "John Doe" logged in with "username" and "password"
	And I have a course named CS169
	And I am on the home page
	When I follow "CS169"
	Then I should be on CS169's page