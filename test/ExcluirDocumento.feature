
Feature: Delete Documents

  Scenario: Deleting a document from storage
    Given I am logged in
    And I have a document named {'Name'} stored
    When I select the {'Name'} from my list of stored documents
    And I tap the {delete} icon
    Then I should see a confirmation dialog with the message {'Are you sure you want to delete this document?'}
    When I tap the {confirm} button on the confirmation dialog
    Then I should see a confirmation message {'Document deleted successfully'}
    And the document named {'Name'} should no longer appear in my list of stored documents
