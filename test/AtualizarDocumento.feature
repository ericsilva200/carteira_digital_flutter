
Functionality: Update Documents

  Scenario: Replacing an old document with a new one
    Given I am logged in
    And I have a document named {'Document'} already stored
    When I select the {'Document'} from my list of stored documents
    And I tap the {edit} button
    And I update the document using the {'camera'} or {'gallery'} option
    When I enter {'Updated Document'} into the {'Document Name'} input field
    And I tap the {replace} button
    Then I should see a confirmation message {'Document replaced successfully'}
    And I should see the document named {'Updated Document'} in my list of stored documents
    And the old document named {'Document'} should no longer appear in my list of stored documents

  Scenario: Replacing an old document with a new one with a name that already exists
    Given I am logged in
    And I have a document named {'Document'} already stored
    And I have another document named {'Updated Document'} already stored
    When I select the {'Document'} from my list of stored documents
    And I tap the {edit} button
    And I update the document using the {'camera'} or {'gallery'} option
    And I enter {'Updated Document'} into the {'Document Name'} input field
    And I tap the {replace} button
    Then I should see a warning message {'A document with this name already exists.'}
    And I should return to the editting section
