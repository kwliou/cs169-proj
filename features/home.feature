
Feature: main homepage is linked to various course pages

#As a student,
#I want to access my course pages from the main homepage
#So that I can view details about my courses

Scenario: student clicks on the link to his/her course
    Given I am "John Doe" logged in with "username" and "password"
    And I am subscribed to "Math 101"
    And I am on the home page
    When I follow "MATH 101"
    Then I should see "re.factored | MATH 101"