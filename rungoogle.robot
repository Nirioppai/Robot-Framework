*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${BROWSER}    chrome
${URL}        https://www.google.com
${SEARCH_INPUT}    name:q
${SEARCH_TERM}    Robot Framework
${DIV_ID}     id=result-stats

# Elements commonly used when testing

# Textbox
# Link
# Button
# Image
# Checkbox
# Text Area
# List Box
# Combo Box
# Radio Button
# Web Table
# Frame

# Actions on a web page

# Type / Write
# Click
# Read
# Select
# Mouse-over
# Drag Drop
# Mouse actions / Keyboard actions


*** Test Cases ***
Google Search Test
    Open Browser To Google
    Input Search Term
    Submit Search
    Check If Div With ID Exists Within 10s
    Close Browser


*** Keywords ***
Open Browser To Google
    Open Browser    ${URL}    ${BROWSER}

Input Search Term
    Wait Until Page Contains Element    ${SEARCH_INPUT}
    Input Text    ${SEARCH_INPUT}    ${SEARCH_TERM}

Submit Search
    Press Keys    ${SEARCH_INPUT}    ENTER

Check If Div With ID Exists Within 10s
    Wait Until Page Contains Element    ${DIV_ID}    10s
    Log    The div with ID "result-stats" exists on the page.

Close Browser
    Close All Browsers


