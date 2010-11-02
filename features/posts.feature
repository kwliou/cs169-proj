Feature: user can manipulate his/her own posts

  #As a Student,
  #I want to be able to read and post questions about my courses
  #So that I can receive help from my peers

  Scenario: Student views own posts
    Given I am "John Doe" logged in with "username" and "password"
    When I visit the posts page
    Then I should see "Listing posts from John Doe"

#  Scenario: Student edits his/her own post
#    Given I am the creator of the "How to get started" post
#    And the post has "Just click post you guys!"
#    When I edit the message with "P.S. Stanford sucks"
#    Then the "How to get started" post should contain "Edit[timestamp]:"
