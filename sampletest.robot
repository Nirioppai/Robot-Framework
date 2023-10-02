*** Keywords ***
CommonFunction1
    [Arguments]    ${message}
    Log    ${message}

*** Test Cases ***
Log Text Message
    CommonFunction1    Log this message
