# features/registration.feature

@user @registration @api
Feature: User management


  Scenario Outline: Successful registration of a new user
    Given I send POST request on resource url "/api/register" using: "<email>" value to "email" field, "<password>" value to "password" field
    When I retrieve the results
    Then the status code should be 201
    And it should have the field "token" containing the not empty value
    # And structure of the response is correct

    Examples:
    |email|password|
    |qwerty@gmail.com|qwerty123|
    |django123@mail.ru|django123|


  Scenario Outline: Unsuccessful registration of a new user
    Given I send POST request on resource url "/api/register" using: "<email>" value to "email" field
    When I retrieve the results
    Then the status code should be 400
    And it should have the field "error" containing the value "Missing password"
    # And structure of the response is correct

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
    # And structure of the response is correct

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
    # And structure of the response is correct

    Examples:
    |name|job|new_job|
    |Georg R|QA Engineer|Automation QA engineer|
    |Pavel K|Senior Programmer|Team Lead|


