@Project
Feature: Project
  Background:
    And base url $(env.base_url_clockify)
    And header Content-Type = application/json

  @AddNewProject @OK
  Scenario Outline: Add a new project
    Given endpoint /v1/workspaces/$(env.workspaceId)/projects/
    And header x-api-key = $(env.xApiKey)
    And set value <nameProject> of key name in body jsons/bodies/newProject.json
    When execute method POST
    Then the status code should be 201
    * print response
    And response should be $.name = <nameProject>
    And validate schema jsons/schemas/addProject.json
    * define projectId = $.id
    * define workspaceId = $.workspaceId
    Examples:
      | nameProject   |
      | TP LowCode 32 |

  @FindProjectId @OK
Scenario: Find project by ID
  Given call ClockifyProject.feature@AddNewProject
  And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
  And header x-api-key = $(env.xApiKey)
  When execute method GET
    * print response
  Then the status code should be 200
  And validate schema jsons/schemas/getProject.json
  And response should be $.id = {{projectId}}

@EditProject @OK
  Scenario Outline: Edit project name
  Given call ClockifyProject.feature@FindProjectId
  And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
  And header x-api-key = $(env.xApiKey)
  And set value <newProjectName> of key name in body jsons/bodies/editProject.json
  When execute method PUT
  * print response
  Then the status code should be 200
  And validate schema jsons/schemas/editProject.json
  And response should be $.name = <newProjectName>
  Examples:
    | newProjectName |
    | Project Edit   |

  @NotAuthorized @NoOK
  Scenario: Project unauthorized to add a new project
    Given endpoint /v1/workspaces/$(env.workspaceId)/projects/
    And header x-api-key = ""
    And body jsons/bodies/newProject.json
    When execute method POST
    Then the status code should be 401
    And response should be $.message = Api key does not exist

  @NotFound @NoOK
  Scenario: Project not found
    Given endpoint /v1/workspaces/$(env.workspaceId)/project/gdgd
    And header x-api-key = $(env.xApiKey)
    When execute method GET
    * print response
    Then the status code should be 404
    And response should be $.message = No static resource v1/workspaces/67fd5a36bc14c211c35956fe/project/gdgd.

  @BadRequest @NoOK
  Scenario: Bad Request
    Given endpoint /v1/workspaces/$(env.workspaceId)/projects/1234
    And header x-api-key = $(env.xApiKey)
    When execute method GET
    * print response
    Then the status code should be 400
    And response should be $.message = Proyecto no pertenece a Espacio de trabajo











      

  
