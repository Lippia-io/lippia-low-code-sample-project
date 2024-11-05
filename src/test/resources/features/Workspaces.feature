@Workspaces
Feature: Workspaces

  Background:
    Given base url https://api.clockify.me/api
    And header x-api-key = MGNkMjRiZWMtMzdlNy00YjUzLWIxMGUtYjQwZTRlZmQxMTk3

  @GetAllMyWorkspaces
  Scenario: GetAllMyWorkspaces
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define workspaceId = $.[0].id





