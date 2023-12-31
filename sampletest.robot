*** Variables ***
${scalar1}    Scalar 1    #This is a Scalar
${scalar2}    100    #This is a Scalar
@{list1}    1    2    3    4    5    #This is a List
&{dict1}    a=1    b=2    c=3    #This is a Dictionary

*** Settings ***
Variables    config.py    #This is how you import a file
Documentation    This is a documentation at SUITE LEVEL
Test Timeout    1s 
Suite Setup    Log    Test Starts
Suite Teardown    Log    Test Ends


*** Keywords ***
CommonFunction1
    [Arguments]    ${message}
    Log    ${message}
UserKeyword1
    Log    This is function 1

UserKeyword2
    Log    This is function 2

GiveFNameLName
    [Arguments]    ${fn}    ${ln}
    Log    ${fn}${SPACE}${ln}

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

returnMessage
    ${a}=    Set Variable     10
    Return From Keyword If    ${a}>=10    Hello    #Return Hello if a>= 10
    Return From Keyword If    ${a}<10    Hi

*** Test Cases ***
TC1
    [Tags]    critical
    [Documentation]    This is a documentation at TEST CASE LEVEL
    [Setup]    Log    This is a setup call    #This is how you can apply setup to a test suite, it needs a log for it to be applied
    Log    Log this message
    # Sleep    10s    #This will fail the test as Test Timeout is defined 1s, and this causes the test case to be delayed by 10s
    Log    Log this message
    [Teardown]    Log    This is a teardown call    #This is how you can apply teardown to a test suite, it needs a log for it to be applied

TC2
    Log    Log this message
    Log    Log this message

TC3
    Log    Log this message
    Log    Log this message
####################
TC4 - Setting Variables and Setting Global Variables
    ${a}=    Set Variable     100    
    ${b}=    Set Variable If    1==1    Value if True    Value if False
    ${c}=    Set Variable    THIS IS A GLOBAL VARIABLE
    Log    ${a}
    Log    ${b}
    Set Global Variable    ${c}
    Log    ${c}

#Convert to Binary
TC5 - Converting to Binary
    ${d}=    Set Variable    99
    ${e}=    Convert To Binary    ${d}
    Log    ${e}

TC6 - Convert To Boolean
    [Documentation]    String to Boolean
    ${f}=    Set Variable    tRuE
    ${g}=    Convert To Boolean    ${f}
    Log    ${g}

TC7 - Different Types of Logs and Importing Resources
    Set Log Level    INFO
    Log    this is Info Log    INFO
    Log    <h1>this is HTML Log</h1>    HTML
    Log    this is WARN Log    WARN
    Log    this is ERROR Log    ERROR
    Log    this is DEBUG Log    DEBUG
    Log    ${list1[0]}    #This is how you access a list
    Log    ${dict1['a']}    #This is how you access a dictionary

####################
#Importing resources
    Log    ${z}    

####################
#Loops
TC8 - For Loops
#Note: Updated Use of for loops
    FOR    ${i}    IN RANGE    1    3
        Log    ${i}
    END
#Note: Updated Use of for in foreach loops
    @{a}=    Create list    1    2    3    4    5
    FOR    ${i}    IN    @{a}
        Log    ${i}
    END
#Note: Conditional Exit of for loop
    @{b}=    Create list    1    2    3    4    5
    FOR    ${i}    IN    @{b}
        Log    ${i}
#Note: Need double equal when executing conditionals
    Exit For Loop If    ${i}==3
    END
#Note: Double for loop 
#Note: Execute second loop for every iteration of first loop
    FOR    ${i}    IN RANGE    1    10
        FOR    ${j}    IN RANGE    11    15
            Log    ${i}__${j}
        END
    END
####################
#Conditionals
TC10 - Set Variable and Set Variable If

    ${cond}=    Set Variable    True
    ${a}=    Set Variable If    ${cond}==False    Value if true    Value if false
    Log    ${a}

TC11 - Run Keyword If

    ${cond}=    Set Variable    True
    Run Keyword If    ${cond}    UserKeyword1    ELSE    UserKeyword2

TC12 - Run Keyword Unless
#Updated method of Run Keyword Unless (Currently Deprecated)
    FOR    ${i}    IN RANGE    1    11
        Log    ${i}
        IF    ${i} <= 5
            Log    ----------
        END
    END

TC13 - Continue and Exit For Loop If
    FOR    ${i}    IN RANGE    1    11    
        Log    start - ${i}
        Continue For Loop If    ${i}>5
        Log    end - ${i}    # This will not run if the condition above is satisfied. It will move on to the next iteration.
    END

    FOR    ${i}    IN RANGE    1    11    
        Log    start - ${i}
        Exit For Loop If    ${i}>5
        Log    end - ${i}    # This will not run if the condition above is satisfied. It will exit the loop completely.
    END

TC14
    ${a}=    Set Variable    10
    Pass Execution If    ${a}==10    This passed the test
    Fail    Forcefully Failing the test

TC15
    [Template]    GiveFNameLName
    Nirio    Del Rosario
    Dean    Caloracan
    Monty    Toft

