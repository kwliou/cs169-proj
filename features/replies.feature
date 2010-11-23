Feature: user can reply to other forum posts
  
  # seems a bit unnecessary
  # Scenario: Student can view nested posts

  Scenario: Student replies to post
    Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101" with item "HW 1"
    And "Bob" posted "Help" with "How to get started"
    When I post a reply "Here is a hint" with "read the instructions"
    Then I should see "read the instructions"

  Scenario: Student replies to a reply
    Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101" with item "HW 1"
    And I posted "How to get started" with "Just click post you guys!"
    And "Bob" replied "Wow" with "thanks that was helpful"
    When I reply to the reply "Yeah" with "you are welcome"
    Then I should see "you are welcome"