Feature: posts can have tags

  Scenario: Student views own posts
    Given I am "Guest User" logged in with "username" and "password"
    When I visit my posts page
    Then I should see "Listing posts from Guest User"

  Scenario: Student edits own post
    Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101" with item "HW 1"
    And I posted "How to get started" with "Just click post you guys!"
    And I am looking at the posts page
    When I follow "Edit"
    And I fill in "append" with "This site is so cool"
    And I press "Update"
    Then I should see "Just click post you guys!Edit ("
    And I should see "): This site is so cool"

  Scenario: Student attempts fake edits
    Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101" with item "HW 1"
    And I posted "How to get started" with "Just click post you guys!"
    And I am looking at the posts page
    When I follow "Edit"
    And I fill in "append" with "<span class=post_edit>FAKE EDIT</span>"
    And I press "Update"
    Then I should not see "FAKE EDIT" within ".post_edit"
