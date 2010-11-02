Feature: the forum page allows users to share information and questions about the course

  #As a Student,
  #I want to be able to read and post questions about my courses
  #So that I can receive help from my peers

Scenario: Student creates a new post
    Given I am logged in as "user"
    And I start a new post "How to get started"
    And I enter in "Just click post you guys!"
    And I add tags "Tip"
    When I click "Post"
    Then I should see "new post successful"
    And the post "How to get started" should be added with tag "Tip"

  Scenario: Student edits his/her own post
    Given I am the creator of the "How to get started" post
    And the post has "Just click post you guys!"
    When I edit the message with "P.S. Stanford sucks"
    Then the "How to get started" post should contain "Edit[timestamp]:"

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
