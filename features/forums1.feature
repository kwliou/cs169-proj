Feature: user can create posts on a course item's forum

  Scenario: Student creates a new post
    Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101" with item "HW 1"
    And I am looking at the posts page
    When I follow "New Post"
    Then I should see "New post"
#
#  Scenario: Student edits his/her own post
#    Given I am the creator of the "How to get started" post
#    And the post has "Just click post you guys!"
#    When I edit the message with "P.S. Stanford sucks"
#    Then the "How to get started" post should contain "Edit[timestamp]:"
#
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
