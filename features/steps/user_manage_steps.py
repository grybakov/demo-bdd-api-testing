import json
import requests
from jsonschema import validate
from behave import given, when, then, step

BASE_URL = 'https://reqres.in'
SCHEMA_PATH = 'c:\\Users\Georgiy\\PycharmProjects\\demo-bdd-api-testing\\features\Schema\\'


@given('I send POST request on resource url "{url}" using: "{email}" value to "email" field, '
       '"{password}" value to "password" field')
def step_impl(context, url, email, password):
    payload = {'email': email, 'password': password}
    context.response = requests.post(BASE_URL + url, json=payload)


@given('I send POST request on resource url "{url}" using: "{name}" value to "name" field, "{job}" value to "job" field')
def step_impl(context, url, name, job):
    payload = {'name': name, 'job': job}
    context.response = requests.post(BASE_URL + url, json=payload)


@given('I send POST request on resource url "{url}" using: "{email}" value to "email" field')
def step_impl(context, url, email):
    payload = {'email': email}
    context.response = requests.post(BASE_URL + url, json=payload)


@given('I retrieve value of the parameter "{param}" from results')
def step_impl(context, param):
    context.param = context.response.json()[param]


@given('I send GET request on resource url "{url}"')
def step_impl(context, url):
    context.response = requests.get(BASE_URL + url)


@when('I send PUT request on resource url "{url}" using: "{name}" value to "name" field, '
      '"{new_job}" value to "job" field')
def step_impl(context, url, name, new_job):
    payload = {'name': name, 'job': new_job}
    user_id = context.param
    context.response = requests.put(BASE_URL + url + user_id, json=payload)


@when('I retrieve the results')
def step_impl(context):
    context.status_code = context.response.status_code
    context.data = context.response.json()


@then('the status code should be {status_code}')
def step_impl(context, status_code):
    assert(int(context.status_code) == int(status_code))


@then('it should have the field "{field}" containing the not empty value')
def step_impl(context, field):
    assert(field in context.data)
    assert(context.data[field] != "")


@then('it should have the field "{field}" containing the value "{field_value}"')
def step_impl(context, field, field_value):
    assert(field in context.data)
    assert(context.data[field] == field_value)


@then('it should have the field "{field}" containing the value "{field_value}" in "{root_field}" field')
def step_impl(context, field, field_value, root_field):
    assert(str(context.data[root_field][field]) == str(field_value))


@then('request structure corresponds to the scheme "{schema_file}"')
def step_impl(context, schema_file):
    with open(SCHEMA_PATH + schema_file, 'r', encoding='utf-8') as f:
        file = json.load(f)
        validate(context.data, file)

