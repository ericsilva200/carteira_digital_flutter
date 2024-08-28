
Functionality: View Documents

  Scenario: Viewing a document
    Given I am logged in
    And I have a document named {'Name'} already stored
    When I tap on the document named {'Name'} in my list of stored documents
    Then I should see the document {'Name'} displayed in a readable way
    And I should see a toolbar with options {'Edit', 'Delete'}
    And I should see the document name {'Name'} and the creation date displayed
    When I tap the {back} button on the toolbar
    Then I should be returned to the list of stored documents
