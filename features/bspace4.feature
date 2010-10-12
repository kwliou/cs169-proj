	
Feature: the forum page allows users to share information and questions about the course

As a Student,
I want to be able to read and post questions about my courses
So that I can receive help from my peers

As a Professor,
I want to be able to read and post discussions about my courses
So that I can answer questions and help students learn through class discussion

Scenario: Student creates a new post
	Given I start a new post "How to get started"
	When I click post
	Then the I should see "new post successful"
	And the post "How to get started" should be added to the forum
	
Scenario: Student edits his/her own post
	Given I am the creator of the "How to get started" post
	When I edit the title to "How start hw1"
	Then there should not be a "How to get started" post
	And there should be a "How to start hw1" post
	
Scenario: Student reads post
	Given there is a post "How to get started"
	When I click on the link to "How to get started"
	Then I should be directed to the entire "How to get started" post
	
Scenario: Student replies to post
	Given there is a post "How to get started"
	When I post a reply "read the instructions"
	Then I should see "reply posted"
	And there should be a reply "read the instructions" below the original post
	
Scenario: Student replies to a reply
	Given there is a reply "read the instructions"
	When I reply "how" to the reply "read the instructions"
	Then I should see "reply posted"
	And there should be a reply "how" below the "read the instructions" reply
	


Scenario: Professor creates a post
	Given I start a new post "How to improve the course"
	When I click post
	Then I should see "new post successful"
	And the post "How to improve the course" should be added to the forum
	
Scenario: Professor edits his/her own post
	Given I am the creator of the "How to improve the course" post
	When I edit the title to "How to improve my teaching"
	Then there should not be a "How to improve the course" post
	And there should be a "How to improve my teaching" post
	
Scenario: Professor deletes a post
	Given there is a post "inappropriate"
	When I click "delete post"
	Then I should see "post deleted"
	And the post "inappropriate" should be deleted from the forum

Scenario: Professor reads post
	Given there is a post "How to get started"
	When I click on the link to "How to get started"
	Then I should be directed to the entire "How to get started" post
	
Scenario: Professor replies to post
	Given there is a post "How to get started"
	When I post a reply "read the instructions"
	Then I should see "reply posted"
	And there should be a reply "read the instructions" below the original post
	
Scenario: Professor replies to a reply
	Given there is a reply "read the instructions"
	When I reply "be more specific" to the reply "read the instructions"
	Then I should see "reply posted"
	And there should be a reply "be more specific" below the "read the instructions" reply
	
Scenario: Professor observes a list of students who have replied to a post
	Given student-a, student-b, and student-c have replied to the post "How to get started"
	When I click on the link "list of replies"
	Then I should see student-a, student-b, and student-c on the list
	
	