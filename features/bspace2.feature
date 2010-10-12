		
Feature: assignments+projects page contains all information about the course's assignments and projects

As a Student,
I want to know details about my assignments and projects
So that I know how I am performing in the course
And I can complete my work before the deadline

As a Professor,
I want to have control over the details of assignments and projects
So that I can assign homework and projects for the students to complete and submit

Scenario: Student observes his past assignment scores
	Given my grade for hw1 is 100/100
	When I am on the assignments+projects page
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
	When I click on the hw1 link on the assignments+projects page
	Then I should see "read chapter 1" as the description

Scenario: Professor posts assignment scores
	Given student-a's grade for hw1 is 100/100
	When I post student-a's hw1 grade
	Then I will see "student-a's hw1 grade posted:100/100"
	And student-a's hw1 grade will be saved
	
Scenario: Professor observes students' past assignments scores
	Given I have posted 100/100 as student-a's hw1 grade
	When I click on the hw1 link
	Then I should see 100/100 as student-a's grade for hw1
	
Scenario: Professor observes the time and date assignments were submitted
	Given student-a submited hw1 at 10:00pm 10-10-2010
	When I click on the hw1 link
	Then I should see "10:00pm 10-10-2010" as student-a's submitted date
	
Scenario: Late submissions are marked for Professors
	Given student-a submited hw1 2 hours late
	When I click on the hw1 link
	Then I should see "late submission: +2:00" as student-a's submitted date
	
Scenario: Professor observes students who have not yet submited assignments that are due
	Given student-a has not submited hw1 before the due date
	When I click on the hw1 link
	Then I should see "not yet submitted" as student-a's submitted date
	
Scenario: Professor posts details about the assignments
	Given I type "read chapter 1" in the description box of hw1
	When I click post
	Then I should see "hw1 posted"
	And hw1's description should be "read chapter 1"
	
