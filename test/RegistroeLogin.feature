
Feature: User Registration and Login

  Scenario: User registration with valid data
    Given I am on the registration screen
    When I enter valid data:
      | UserName        | Pedro            |
      | Password         | Password123      |
    And I tap the {submit} button
    Then I should see a confirmation message {'Registration successful!'}
    And I should be redirected to the login screen

  Scenario: User registration with an User Name
    Given I am on the registration screen
    When I enter registration data:
      | UserName        | Pedro            |
      | Password         | Password123      |
    And the UserName 'Pedro' is already registered
    And I tap the {submit} button
    Then I should see an error message {'User Name already registered'}
    And I should remain on the registration screen

  Scenario: User login with correct credentials
    Given I am on the login screen
    When I enter login credentials:
      | UserName        | Pedro           |
      | Password         | Password123     |
    And I tap the {login} button
    Then I should be logged in successfully

  Scenario: User login with incorrect credentials
    Given I am on the login screen
    When I enter login credentials:
      | UserName        | Pedro           |
      | Password         | Password123     |
    And I tap the {login} button
    Then I should see an error message {'Invalid email or password'}
    And I should remain on the login screen