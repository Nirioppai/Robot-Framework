*** Variables ***
${scalar1}        Scalar 1             # This is a Scalar
${scalar2}        100                  # This is a Scalar
@{list1}          1    2    3    4    5    # This is a List
&{dict1}          a=1    b=2    c=3    # This is a Dictionary

*** Settings ***
Variables        config.py             # This is how you import a file
Documentation    This is a documentation at SUITE LEVEL
Test Timeout     1s 
Suite Setup      Log    Test Starts
Suite Teardown   Log    Test Ends

*** Keywords ***
CommonFunction1
    [Arguments]    ${message}
    Log    ${message}

suite_setup
    Log    SETUP SUITE

suite_teardown
    Run Keyword If All Tests Passed    finalFunction
    Log    ENDING SUITE

test_setup
    Log    SETUP TEST

test_teardown
    Log    ENDING TEST

finalFunction
    Log    This is the final function

*** Test Cases ***
TC1
    [Tags]            critical
    [Documentation]   This is a documentation at TEST CASE LEVEL
    [Setup]           Log    This is a setup call
    Log               Log this message
    Log               Log this message
    [Teardown]        Log    This is a teardown call

TC2
    Log    Log this message
    Log    Log this message

TC3
    Log    Log this message
    Log    Log this message

TC4
    ${a}=    Set Variable         100    
    ${b}=    Set Variable If      1==1    Value if True    Value if False
    ${c}=    Set Variable         THIS IS A GLOBAL VARIABLE
    Log      ${a}
    Log      ${b}
    Set Global Variable    ${c}
    Log      ${c}

TC5
    ${d}=    Set Variable        99
    ${e}=    Convert To Binary   ${d}
    Log      ${e}

TC6 - Convert To Boolean
    [Documentation]    String to Boolean
    ${f}=              Set Variable    tRuE
    ${g}=              Convert To Boolean    ${f}
    Log                ${g}

TC7
    Set Log Level    INFO
    Log    this is Info Log    INFO
    Log    <h1>this is HTML Log</h1>    HTML
    Log    this is WARN Log    WARN
    Log    this is ERROR Log   ERROR
    Log    this is DEBUG Log   DEBUG
    Log    ${list1[0]}            # This is how you access a list
    Log    ${dict1['a']}          # This is how you access a dictionary

TC8
    FOR    ${i}    IN RANGE    1    3
        Log    ${i}
    END
    @{a}=    Create list    1    2    3    4    5
    FOR    ${i}    IN    @{a}
        Log    ${i}
    END
    @{b}=    Create list    1    2    3    4    5
    FOR    ${i}    IN    @{b}
        Log    ${i}
        Exit For Loop If    ${i}==3
    END
    FOR    ${i}    IN RANGE    1    10
        FOR    ${j}    IN RANGE    11    15
            Log    ${i}__${j}
        END
    END

TC10
    ${cond}=    Set Variable    True
    ${a}=       Set Variable If    ${cond}==False    Value if true    Value if false
    Log         ${a}
