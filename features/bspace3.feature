
Feature: exams+quizzes page contains all scores of the courses exams and quizzes

As a Student,
I want to be able to view all my past quizzes and exams scores
So that I can predict my grade in the class

As a Professor,
I want to be able to post exam/quiz scores
So that I can give students feedback on how well they are doing in the course

Scenario: Student observes his past exam/quiz score
	Given my score for exam1 is 100/100
	When I am on the exams+quizzes page
	Then I should see 100/100 as my exam1 score



Scenario: Professor posts exam/quiz score
	Given student-a scored 100/100 on exam1
	When I post student-a's score
	Then I should see "student-a's exam1 grade posted: 100/100"
	And I should see 100/100 as student-a's exam1 score
	

	