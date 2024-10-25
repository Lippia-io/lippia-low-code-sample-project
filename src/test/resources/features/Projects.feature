@Projects
Feature: Projects

  Background:
    Given base url https://api.clockify.me/api
    And header x-api-key = MGNkMjRiZWMtMzdlNy00YjUzLWIxMGUtYjQwZTRlZmQxMTk3


  @GetAllProjects
  Scenario: GetAllProjectsOnWorkspace
    Given call Projects.feature@AddNewProject
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    When execute method GET
    Then the status code should be 200

  @AddNewProject
  Scenario: AddNewProject
    Given call Workspaces.feature@AddWorkspace
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And header Content-Type = Application/json
    And body jsons/bodies/AddNewProject.json
    When execute method POST
    Then the status code should be 201
    And response should be $.name = New Project
    * define projectId = $.id

  @FindProjectById
  Scenario: FindProjectById
    Given call Projects.feature@AddNewProject
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method GET
    Then the status code should be 200
    And response should be $.name = New Project

  @UpdateProjectOnWorkspace
  Scenario: UpdateProjectOnWorkspace
    Given call Projects.feature@FindProjectById
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And header Content-Type = Application/json
    And body jsons/bodies/UpdateProject.json
    And set value Project1 of key name in body jsons/bodies/UpdateProject.json
    When execute method PUT
    Then the status code should be 200
    And response should be $.name = Project1
    * define projectId = $.id

  @FindUpdatedProjectById
  Scenario: FindUpdatedProjectById
    Given call Projects.feature@UpdateProjectOnWorkspace
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method GET
    Then the status code should be 200
    And response should be $.name = Project1

  @UpdateProjectEstimate
  Scenario: UpdateProjectEstimate
    Given call Projects.feature@AddNewProject
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}/estimate
    And header Content-Type = Application/json
    And body jsons/bodies/UpdateProjectEstimate.json
    When execute method PATCH
    Then the status code should be 200

  @UpdateProjectMemberships
  Scenario: UpdateProjectMemberships
    Given call Projects.feature@AddNewProject
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}/memberships
    And header Content-Type = Application/json
    And body jsons/bodies/UpdateProjectMemberships.json
    When execute method PATCH
    Then the status code should be 200

  @AssignUsersToProject
  Scenario: AssignUsersToProject
    Given call Projects.feature@AddNewProject
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}/memberships
    And header Content-Type = Application/json
    And body jsons/bodies/AssignUsersToProject.json
    When execute method POST
    Then the status code should be 200
    * define userId = $.id

  @ArchiveProject
  Scenario: ArchiveProject
    Given call Projects.feature@AddNewProject
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And header Content-Type = Application/json
    And body jsons/bodies/ArchiveProject.json
    When execute method PUT
    Then the status code should be 200

  @DeleteProject
  Scenario: DeleteProject
    Given call Projects.feature@ArchiveProject
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method DELETE
    Then the status code should be 200

  @FindProjectByIdBadRequest @FailedScenario
  Scenario: FindProjectByIdBadRequest
    Given call Projects.feature@DeleteProject
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method GET
    Then the status code should be 400
    And response should be $.message = Project doesn't belong to Workspace

  @FindProjectByIdNotFound  @FailedScenario
  Scenario: FindProjectByIdNotFound
    Given call Projects.feature@DeleteProject
    And endpoint /v1/workspace/{{workspaceId}}/projects/{{projectId}}
    When execute method GET
    Then the status code should be 404

  @AddNewProjectUnauthorized @FailedScenario
  Scenario: AddNewProjectUnauthorized
    Given call Workspaces.feature@AddWorkspace
    And header x-api-key = MGNkMjRiZWMtMzdlNy00YjUzLWIxMGUtYjQwZTRlZmQ
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And header Content-Type = Application/json
    And body jsons/bodies/AddNewProject.json
    When execute method POST
    Then the status code should be 401
    And response should be $.message = Api key does not exist



