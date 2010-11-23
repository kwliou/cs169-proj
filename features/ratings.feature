Feature: user can create rating for a course

  Scenario: Student clicks new rating
    Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101"
    And I am looking at the ratings page
    When I follow "New Rating"
    Then I should see "New rating"

    Scenario: Student creates new rating
    Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101"
    And I am making a new rating
    When I choose "rating_easiness_1"
	And I choose "rating_interest_1"
	And I choose "rating_work_load_1"
    And I press "Create"
    Then I should see "WTF? (1/5)"
	And I should not see "eh...can't complain (3)"

	Scenario: Student edits his/her own rating
    Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101"
    And I rated all 1
    And I am looking at the ratings edit page
    When I choose "rating_easiness_5"
    And I press "Update"
    Then I should see "I swear this is elementary school material (5/5)"
    And I should not see "WTF? (1/5)"

	Scenario: Student can only create 1 rating per course
	Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101"
    And I rated all 1
	And I am looking at the ratings page
	Then I should not see "New rating"
	
	Scenario: Student can delete his own rating
	Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101"
    And I am making a new rating
    When I choose "rating_easiness_1"
	And I choose "rating_interest_1"
	And I choose "rating_work_load_1"
    And I press "Create"
	And I am looking at the ratings page
	And I follow "Remove"
	Then I should see "New rating"
	
	Scenario: Student cannot edit/delete others' ratings
	Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101"
	And someone rated all 1
	When I am looking at the ratings page
	Then I should not see "Edit"
	And I should not see "Delete"
	
	#Scenario: Student can see average ratings
	#Given I am "Guest User" logged in with "username" and "password"
    #And I am subscribed to "Math 101"
	#And someone rated all 2
	#And I am making a new rating
    #When I choose "rating_easiness_4"
	#And I choose "rating_interest_4"
	#And I choose "rating_work_load_4"
    #And I press "Create"
	#And I am looking at the ratings page
	#Then I should see "3"
	
