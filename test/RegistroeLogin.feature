
Functionality: User Registration and Login

  Scenario: Registering a new user
    Given that I am on the registration page
    When I enter my username and password
    And I confirm my registration
    Then I should be redirected to the login page

  Scenario: Logging in with valid credentials
    Given that I am on the login page
    When I enter my username and password
    And I press the login button
    So I must be logged into the application
    And I should see my dashboard