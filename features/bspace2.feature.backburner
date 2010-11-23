		
Feature: assignments+projects page contains all information about the course's assignments and projects

#As a Student,
#I want to know details about my assignments and projects
#So that I know how I am performing in the course
#And I can complete my work before the deadline

Scenario: Student observes his past assignment scores
	Given my grade for hw1 is 100/100
	When I visit the assignments+projects page
	Then I will see my grade for hw1 is 100/100
	
Scenario: Student submits assignments before due date
	Given the due date for hw1 is 12:00am 10-10-2010
	When I submit hw1 at 10:00pm 10-10-2010
	Then I should see "submission successful"
	And my hw1 should be sent to the Professor

Scenario: Student submits assignments after due date
	Given the due date for hw1 is 12:00am 10-10-2010
	When I submit hw1 at 10:00pm 10-11-2010
	Then I should see "late submission: +22:00"
	And my hw1 should be sent to the Professor marked as "late submission: +22:00"

Scenario: Student observes details about his assignments
	Given hw1's description is "read chapter 1"
	When I click on the "Show" link on the assignments+projects page
	Then I should see "read chapter 1" as the description
