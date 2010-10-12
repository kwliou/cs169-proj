>> * main homepage (w/ links to various courses)
>> * course homepage (has links to various "items") (accessed from main
>> homepage)
>> * assignments+projects page (accessed from course homepage)
>> * exams/quizzes page (accessed from course homepage)
>> * forums page (accessed from assignment/exam/project/etc. homepage)

Feature: main homepage is linked to various course pages

As a student,
I want to access my course pages from the main homepage
So that I can view details about my courses

Scenario: student clicks on the link to his/her course
	Given I am a student of the CS169 course
	When I click on the CS169 link
	Then I am directed to the student's version of the CS169 page
	
As a Professor,
I want to access my course pages from the main homepage
So that I can view details about my courses

Scenario: Professor clicks on the link to his/her course
	Given I am a Professor of the CS169 course
	When I click on the CS169 link
	Then I am directed to the Professor's version of the CS169 page
	
Feature: course page is linked to various pages containing course details

As a student,
I want to access details of my course from the course page
So that I have more information about the course's past, current, and future situation

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
	
As a Professor,
I want to access details of my course from the course page
So that I have more information about the course's past and current situation
And I can make any updates needed

Scenario: Professor clicks on the assignments+projects link
	Given I am a Professor of the CS169 course
	When I click on the assignments+projects link on the CS169 course page
	Then I am directed to the Professor's version of the CS169 assignemnts+projects page

Scenario: Professor clicks on the exams+quizzes link
	Given I am a Professor of the CS169 course
	When I click on the exams+quizzes link on the CS169 course page
	Then I am directed to the Professor's version of the CS169 exams+quizzes page
	
Scenario: Professor clicks on the forums link
	Given I am a Professor of the CS169 course
	When I click on the forums link on the CS169 course page
	Then I am directed to the Professor's version of the CS169 forums page
	
Feature: assignments+projects page contains all information about the course's assignments and projects

As a Student,
I want to know details about my assignments and projects
So that I know how I am performing in the course
And I can complete my work before the deadline

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
	
As a Professor,
I want to have control over the details of assignments and projects
So that I can assign homework and projects for the students to complete and submit

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
	
Feature: exams+quizzes page contains all scores of the courses exams and quizzes

As a Student,
I want to be able to view all my past quizzes and exams scores
So that I can predict my grade in the class

Scenario: Student observes his past exam/quiz score
	Given my score for exam1 is 100/100
	When I am on the exams+quizzes page
	Then I should see 100/100 as my exam1 score

As a Professor,
I want to be able to post exam/quiz scores
So that I can give students feedback on how well they are doing in the course

Scenario: Professor posts exam/quiz score
	Given student-a scored 100/100 on exam1
	When I post student-a's score
	I should see "student-a's exam1 grade posted: 100/100"
	Then I should see 100/100 as student-a's exam1 score
	
Feature: the forum page allows users to share information and questions about the course

As a Student,
I want to be able to read and post questions about my courses
So that I can receive help from my peers

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
	
As a Professor,
I want to be able to read and post discussions about my courses
So that I can answer questions and help students learn through class discussion

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
	
	