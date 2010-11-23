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

  @wip
  Scenario: Student edits his/her own post
    Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101" with item "HW 1"
    Given I posted "How to get started" with "Just click post you guys!"
    And I am looking at the posts page
    When I follow "Edit"
    And I fill in "Body" with "This site is so cool"
    And I press "Update"
    Then I should see "Just click post you guys Edit("
    #the "How to get started" post should contain "Edit[timestamp]:"

#  Scenario: Student reads post
#    Given there is a post "How to get started"
#    When I click on the link to "How to get started"
#    Then I should be directed to the entire "How to get started" post
#
#  Scenario: Student replies to post
#    Given there is a post "How to get started"
#    When I post a reply "read the instructions"
#    Then I should see "reply posted"
#    And there should be a reply "read the instructions" below the original post
#
#  Scenario: Student replies to a reply
#    Given there is a reply "read the instructions"
#    When I reply "how" to the reply "read the instructions"
#    Then I should see "reply posted"
#    And there should be a reply "how" below the "read the instructions" reply
