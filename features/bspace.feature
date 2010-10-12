
Feature: main homepage is linked to various course pages

As a student,
I want to access my course pages from the main homepage
So that I can view details about my courses

As a Professor,
I want to access my course pages from the main homepage
So that I can view details about my courses

Scenario: student clicks on the link to his/her course
	Given I am a student of the CS169 course
	When I click on the CS169 link
	Then I am directed to the student's version of the CS169 page

Scenario: Professor clicks on the link to his/her course
	Given I am a Professor of the CS169 course
	When I click on the CS169 link
	Then I am directed to the Professor's version of the CS169 page
	
