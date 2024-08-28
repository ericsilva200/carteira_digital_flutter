
Functionality: Delete Documents

  Scenario: Deleting a document
    Given that I have a document stored
    When I select the document to delete
    And I confirm the deletion
    Then the document should no longer appear in my list of stored documents
