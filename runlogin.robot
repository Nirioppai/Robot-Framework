*** Settings ***
Library         SeleniumLibrary
Suite Setup     Open Browser To Login Page
Suite Teardown  Close All Browsers
Test Setup      Navigate To Login Page
Test Teardown   Logout From Application

*** Variables ***
${BROWSER}          chrome
${URL}              https://test-grip.georisk.gov.ph/sso/login?issuer=https%3A%2F%2Ftest-grip.georisk.gov.ph%2Foauth%2Fauthorize&clientId=r1iyFdcblP97nY7mbaSaJU2mAol774zrHqlSvFvn&clientSecret=ZaCeazkJ4cb9eZsLrRGlrnApS60g0YanBKq2VcKaJCOf4cAEzO88ALxzmI2AAY64735rR1Y2oOCan7gv&redirectUri=https%3A%2F%2Ftest-geoanalytics.georisk.gov.ph%2Fsso%2Fcb&appId=3&postLogoutRedirectUri=https%3A%2F%2Ftest-geoanalytics.georisk.gov.ph%2Fsso%2Flogout
${USERNAME}         grip_padregarcia_acmendoza
${PASSWORD}         batangas_016
${USERNAME_FIELD}   id=username
${PASSWORD_FIELD}   id=password-input
${LOGIN_BUTTON}     id=login-button
${LOGOUT_BUTTON}    id=logoutBtn
${SUCCESSFUL_LOGIN_ELEMENT}  css=span.hidden-xs.d-none.d-sm-inline-block.m-l-5
${FAILURE_ALERT}    css=div.alert.alert-warning.alert-dismissible.fade.show
${CAPTCHA_ALERT}    css=div.alert.alert-danger.alert-dismissible.fade.show

*** Test Cases ***
Valid Login
    Input Username    ${USERNAME}
    Input Password    ${PASSWORD}
    Handle CAPTCHA
    Submit Login
    Validate Captcha Not Filled
    Validate Successful Login

Invalid Login
    Input Username    wrongUsername
    Input Password    wrongPassword
    Handle CAPTCHA
    Submit Login
    Validate Captcha Not Filled
    Validate Login Failure

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}

Navigate To Login Page
    Go To    ${URL}

Input Username
    [Arguments]    ${username}
    Input Text    ${USERNAME_FIELD}    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    ${PASSWORD_FIELD}    ${password}

Handle CAPTCHA
    # CAPTCHA handling would generally be manual, but some methods may automate it.
    # Here's a placeholder for the CAPTCHA handling step:
    Log    Manual CAPTCHA verification required

Submit Login
    Click Button    ${LOGIN_BUTTON}

Validate Successful Login
    Wait Until Page Contains Element    ${SUCCESSFUL_LOGIN_ELEMENT}    # Wait until the web page displays the element indicating successful login.
    ${user_name} =    Get Text    ${SUCCESSFUL_LOGIN_ELEMENT}         # Retrieve the displayed text from the successful login element.
    Should Be Equal As Strings    ${user_name}    Abuel C. Mendoza    # Verify that the retrieved text matches the expected username.
    Log    Login successful                                         # Log a message to indicate a successful login verification.

Validate Captcha Not Filled
    Wait Until Page Contains Element    ${CAPTCHA_ALERT}              # Wait until the CAPTCHA warning alert appears on the page.
    ${alert_text} =    Get Text    ${CAPTCHA_ALERT}                  # Retrieve the displayed text from the CAPTCHA warning alert.
    Should Contain    ${alert_text}    The g-recaptcha-response field is required.   # Verify the retrieved text indicates the CAPTCHA was not filled.
    Log    Login failed due to CAPTCHA: ${alert_text}                # Log a message indicating the login failure due to CAPTCHA.

Validate Login Failure
    Wait Until Page Contains Element    ${FAILURE_ALERT}                 # Wait until the warning alert appears on the page.
    ${alert_text} =    Get Text    ${FAILURE_ALERT}                     # Retrieve the displayed text from the warning alert.
    Should Contain    ${alert_text}    Invalid username or password.    # Verify the retrieved text indicates a failed login attempt.
    Log    Login failed: ${alert_text}                                 # Log a message indicating the login failure reason.


Logout From Application
    Click Button    ${LOGOUT_BUTTON}
    Wait Until Page Contains    You have been logged out
    Log    Logged out from application
