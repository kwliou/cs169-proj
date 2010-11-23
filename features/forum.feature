Feature: user can create posts on a course item's forum

  Scenario: Student clicks new post
    Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101" with item "HW 1"
    And I am looking at the posts page
    When I follow "New Post"
    Then I should see "New post"

  Scenario: Student creates new post
    Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101" with item "HW 1"
    And I am making a new post
    When I fill in the following:
      | Title   | Hey everyone |
      | Body    | Welcome!     |
      | Tags    | Other        |
    And I press "Create"
    Then I should see "Welcome!"