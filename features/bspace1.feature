	
Feature: course page is linked to various pages containing course details

#As a student,
#I want to access details of my course from the course page
#So that I have more information about the course's past, current, and future situation

Scenario: student clicks on the assignments+projects link
	Given I am a student of the CS169 course
	When I click on the assignments+projects link on the CS169 course page
	Then I am directed to the Student's version of the CS169 assignemnts+projects page

Scenario: student clicks on the exams+quizzes link
	Given I am a student of the CS169 course
	When I click on the exams+quizzes link on the CS169 course page
	Then I am directed to the Student's version of the CS169 exams+quizzes page
	
Scenario: student clicks on the forums link
	Given I am a student of the CS169 course
	When I click on the forums link on the CS169 course page
	Then I am directed to the Student's version of the CS169 forums page