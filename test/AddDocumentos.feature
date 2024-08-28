
Functionality: Add Documents

  Scenario: Adding a document via photo or scan
    Given that I am logged in
    When I take a photo or scan a document
    And I add the document to my storage
    Then I should see the document in my list of stored documents