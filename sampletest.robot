*** Settings ***
Documentation    This is a test suite
Test Timeout    1s 
Suite Setup    Log    Test Starts
Suite Teardown    Log    Test Ends

# *** Keywords ***
# CommonFunction1
#     [Arguments]    ${message}
#     Log    ${message}

*** Test Cases ***
TC1
    Log    HELLOOO DJHASGDHJAGDJHAGDHJK
    Sleep    10s    #This will fail the test as Test Timeout is defined 1s, and this causes the test case to be delayed by 10s
    Log    Log this message

TC2
    Log    Log this message
    Log    Log this message

TC3
    Log    Log this message
    Log    Log this message
