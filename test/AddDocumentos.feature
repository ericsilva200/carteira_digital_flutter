
Functionality: Add Documents

  Scenario: Adding a new document via camera
    Given I am logged in
    When I tap the {camera} icon
    And I capture a new photo
    And I see a text field labeled {'Document Name'}
    When I enter {'Name'} into the {'Document Name'} input field
    And I tap the {save} button to add the document to my storage
    Then I should see a confirmation message {'Document added successfully'}
    And I should see the document named {'Name'} in my list of stored documents

  Scenario: Adding a new document from the gallery
    Given I am logged in
    When I tap the {gallery} icon
    And I select an image named {'Document.jpg'}
    And I see a text field labeled {'Document Name'}
    When I enter {'Name'} into the {'Document Name'} input field
    And I tap the {save} button to add the document to my storage
    Then I should see a confirmation message {'Document added successfully'}
    And I should see the document named {'Name'} in my list of stored documents

  Scenario: Adding a document without providing a name
    Given I am logged in
    When I tap the {camera} icon
    And I capture a new photo
    And I see a text field labeled {'Document Name'}
    When I leave the {'Document Name'} input field empty
    And I tap the {save} button to add the document to my storage
    Then I should see an error message {'Document name is required'}
    And the document should not be added to my list of stored documents