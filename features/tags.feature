Feature: posts can have tags

  @wip
  Scenario: Student adds tags
    Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101" with item "HW 1"
    And I am making a new post
    When I fill in the following:
      | Title   | Hey everyone |
      | Body    | Welcome!     |
      | Tags    | Tip          |
    And I press "Create"
    Then I should see "tags: tip"

  @wip
  Scenario: Student searches tags
    Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101" with item "HW 1"
    And I posted "How to get started" with "Just click post you guys!" under "tip"
    And I posted "This place is cool" with "OMGGG" under "praise"
    And I am looking at the posts page
    When I follow "tip"
    And I press "Search"
    Then I should not see "This place is cool"

  Scenario: Student attempts fake edits
    Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101" with item "HW 1"
    And I posted "How to get started" with "Just click post you guys!"
    And I am looking at the posts page
    When I follow "Edit"
    And I fill in "append" with "<span class=post_edit>FAKE EDIT</span>"
    And I press "Update"
    Then I should not see "FAKE EDIT" within ".post_edit"
