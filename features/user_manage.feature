# features/registration.feature

@user @registration @api
Feature: User management


  Scenario Outline: Successful registration of a new user
    Given I send POST request on resource url "/api/register" using: "<email>" value to "email" field, "<password>" value to "password" field
    When I retrieve the results
    Then the status code should be 201
    And it should have the field "token" containing the not empty value
    And request structure corresponds to the scheme "register_success.schema"

    Examples:
    |email|password|
    |qwerty@gmail.com|qwerty123|
    |Django123@mail.ru|django123|
    |Django@russia.ru|Django|


  Scenario Outline: Unsuccessful registration of a new user
    Given I send POST request on resource url "/api/register" using: "<email>" value to "email" field
    When I retrieve the results
    Then the status code should be 400
    And it should have the field "error" containing the value "Missing password"
    And request structure corresponds to the scheme "register_unsuccess.schema"

    Examples:
    |email|
    |qwerty@gmail.com|
    |django123@mail.ru|


  Scenario Outline: Create new user
    Given I send POST request on resource url "/api/users" using: "<name>" value to "name" field, "<job>" value to "job" field
    When I retrieve the results
    Then the status code should be 201
    And it should have the field "id" containing the not empty value
    And it should have the field "name" containing the value "<name>"
    And it should have the field "job" containing the value "<job>"
    And request structure corresponds to the scheme "create_user.schema"

    Examples:
    |name|job|
    |Georg R|QA Engineer|
    |Pavel K|Senior Programmer|


  Scenario Outline: Create new user and update job fields
    Given I send POST request on resource url "/api/users" using: "<name>" value to "name" field, "<job>" value to "job" field
    And I retrieve value of the parameter "id" from results
    When I send PUT request on resource url "/api/users/" using: "<name>" value to "name" field, "<new_job>" value to "job" field
    And I retrieve the results
    Then the status code should be 200
    And it should have the field "name" containing the value "<name>"
    And it should have the field "job" containing the value "<new_job>"
    And request structure corresponds to the scheme "update_user.schema"

    Examples:
    |name|job|new_job|
    |Georg R|QA Engineer|Automation QA engineer|
    |Pavel K|Senior Programmer|Team Lead|


  Scenario: Get single user
    Given I send GET request on resource url "/api/users/2"
    When I retrieve the results
    Then the status code should be 200
    And it should have the field "data" containing the not empty value
    And it should have the field "id" containing the value "2" in "data" field
    And it should have the field "first_name" containing the value "Janet" in "data" field
    And it should have the field "last_name" containing the value "Weaver" in "data" field
    And request structure corresponds to the scheme "single_user.schema"


  Scenario: Single user not found
    Given I send GET request on resource url "/api/users/777"
    When I retrieve the results
    Then the status code should be 404

