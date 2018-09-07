Demo: Using BDD in API automation testing
====================
Demo tests written for the API service [ReqRes](https://reqres.in/) (use REST)

Example Gherkin case
---------------
More tests by [link](https://github.com/grybakov/MerchRoutes/blob/master/features/)
```gherkin
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
```

Example Steps
---------------
More steps by [link](https://github.com/grybakov/MerchRoutes/blob/master/features/steps)
```python
@given('I send POST request on resource url "{url}" using: "{name}" value to "name" field, "{job}" value to "job" field')
def step_impl(context, url, name, job):
    payload = {'name': name, 'job': job}
    context.response = requests.post(BASE_URL + url, json=payload)

@given('I retrieve value of the parameter "{param}" from results')
def step_impl(context, param):
    context.param = context.response.json()[param]

@when('I send PUT request on resource url "{url}" using: "{name}" value to "name" field, '
      '"{new_job}" value to "job" field')
def step_impl(context, url, name, new_job):
    payload = {'name': name, 'job': new_job}
    user_id = context.param
    context.response = requests.put(BASE_URL + url + user_id, json=payload)
```

Requirements
---------------

  - [behave](https://github.com/behave/behave)
  - [jsonschema](https://github.com/Julian/jsonschema)
  - [requests](https://github.com/requests/requests)
  - Other requirements you can see in requirements.txt