Feature: posts can have tags

  Scenario: Student adds tags
    Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101" with item "HW 1"
    And I am making a new post
    When I fill in the following:
      | Title   | Hey everyone |
      | Body    | Welcome!     |
      | Tags    | Tip          |
    And I press "Create"
    Then I should see "Tags: tip"

  Scenario: Student searches one tag
    Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101" with item "HW 1"
    And I posted "How to get started" with "Just click post you guys!" under "tip"
    And I posted "This place is cool" with "OMGGG" under "praise"
    And I am looking at the posts page
    When I follow "tip"
    And I press "Search"
    Then I should not see "This place is cool"

  Scenario: Student searches multiple tags
    Given I am "Guest User" logged in with "username" and "password"
    And I am subscribed to "Math 101" with item "HW 1"
    And I posted "How to get started" with "Just click post you guys!" under "tip"
    And I posted "This place is cool" with "OMGGG" under "praise"
    And I posted "This place is lame" with "Lame!!" under "criticism"
    And I am looking at the posts page
    When I follow "tip"
    And I follow "praise"
    And I press "Search"
    Then I should not see "This place is lame"

# Webrat doesn't play nice with Javascript
# @wip
#  Scenario: Student searches multiple inclusive tags
#    Given I am "Guest User" logged in with "username" and "password"
#    And I am subscribed to "Math 101" with item "HW 1"
#    And I posted "This place is cool. do this" with "OMGGG" under "praise, tip"
#    And I posted "This place is cool. OMG" with "OMGGGds" under "praise"
#    And I am looking at the posts page
#    When I follow "tip"
#    And I follow "praise"
#    And I check "Match all tags?"
#    And I press "Search"
#    Then I should not see "This place is cool. OMG"
#    And I should see "This place is cool. do this"
