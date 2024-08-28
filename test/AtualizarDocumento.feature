
Functionality: Update Documents

  Scenario: Replacing an old document with a new one
    Given that I have a document stored
    When I select the document to edit
    And I take a new photo or scan
    And I replace the old document with the new one
    So I should see the new document in place of the old one in my list
