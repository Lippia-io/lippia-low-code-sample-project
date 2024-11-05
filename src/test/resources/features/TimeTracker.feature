@TimeTracker      @SuccessfulScenarios
Feature: TimeTracker

  Background:
    Given base url https://api.clockify.me/api
    And header x-api-key = MGNkMjRiZWMtMzdlNy00YjUzLWIxMGUtYjQwZTRlZmQxMTk3

  @GetTimeEntriesForAUser
  Scenario: GetTimeEntriesForAUserOnWorkspace
    Given call Workspaces.feature@GetAllMyWorkspaces
    And endpoint /v1/workspaces/{{workspaceId}}/user/66fc8b76b4a5693bcb194d34/time-entries
    When execute method GET
    Then the status code should be 200
    * define id = $.[0].id

  @AddANewTimeEntry
  Scenario: AddANewTimeEntry
    Given call Workspaces.feature@GetAllMyWorkspaces
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries
    And header Content-Type = Application/json
    And body jsons/bodies/AddNewTimeEntry.json
    When execute method POST
    Then the status code should be 201

  @UpdateTimeEntry
  Scenario: UpdateTimeEntry
    Given call TimeTracker.feature@GetTimeEntriesForAUser
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{id}}
    And header Content-Type = Application/json
    And body jsons/bodies/UpdateTimeEntry.json
    When execute method PUT
    Then the status code should be 200

  @DeleteTimeEntry
  Scenario: DeleteTimeEntryFromWorkspace
    Given call TimeTracker.feature@GetTimeEntriesForAUser
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{id}}
    When execute method DELETE
    Then the status code should be 204

