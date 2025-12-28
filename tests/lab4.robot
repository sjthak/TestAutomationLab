*** Settings ***
Library         SeleniumLibrary
Suite Setup     Open Registration Page
Suite Teardown  Close Browser
Test Setup      Go To    ${URL}

*** Variables ***
${URL}          http://localhost:7272/Registration.html
${BROWSER}      chrome

*** Keywords ***
Open Registration Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Input Registration Data
    [Arguments]    ${fname}    ${lname}    ${org}    ${email}    ${phone}
    Input Text    id=firstname       ${fname}
    Input Text    id=lastname        ${lname}
    Input Text    id=organization    ${org}
    Input Text    id=email           ${email}
    Input Text    id=phone           ${phone}

Click Register
    
    Click Button    id=registerButton

*** Test Cases ***
Register Success
    Input Registration Data    Somyod    Sodsai    CS KKU    somyod@kkumail.com    091-001-1234
    Click Register
    Title Should Be    Success
    Page Should Contain    Thank you for registering with us.

Register Success Without Organization
    Input Registration Data    Somyod    Sodsai    ${EMPTY}    somyod@kkumail.com    091-001-1234
    Click Register
    Title Should Be    Success

Empty First Name
    Input Registration Data    ${EMPTY}    Sodsai    CS KKU    somyod@kkumail.com    091-001-1234
    Click Register
    Page Should Contain    *Please enter your first name!!

Empty Last Name
    Input Registration Data    Somyod    ${EMPTY}    CS KKU    somyod@kkumail.com    091-001-1234
    Click Register
    Page Should Contain    *Please enter your last name!!

Empty First And Last Name
    Input Registration Data    ${EMPTY}    ${EMPTY}    CS KKU    somyod@kkumail.com    091-001-1234
    Click Register
    Page Should Contain    *Please enter your name!!

Empty Email
    Input Registration Data    Somyod    Sodsai    CS KKU    ${EMPTY}    091-001-1234
    Click Register
    Page Should Contain    *Please enter your email!!

Empty Phone Number
    Input Registration Data    Somyod    Sodsai    CS KKU    somyod@kkumail.com    ${EMPTY}
    Click Register
    Page Should Contain    *Please enter your phone number!!

Invalid Phone Number
    Input Registration Data    Somyod    Sodsai    CS KKU    somyod@kkumail.com    1234
    Click Register
    Page Should Contain    Please enter a valid phone number!!