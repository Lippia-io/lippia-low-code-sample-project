@Workspaces
Feature: Workspaces

  Background:
    Given base url https://api.clockify.me/api
    And header x-api-key = MGNkMjRiZWMtMzdlNy00YjUzLWIxMGUtYjQwZTRlZmQxMTk3

  @AddWorkspace
  Scenario: AddWorkspace
    And endpoint /v1/workspaces
    And header Content-Type = Application/json
    And body jsons/bodies/AddWorkspace.json
    When execute method POST
    Then the status code should be 201
    And response should be $.name = New workspace
    * define workspaceId = $.id



