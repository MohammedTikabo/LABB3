*** Settings ***
Documentation       This is some test suits for infotv carboking webbpage
Library             SeleniumLibrary

Test Setup          Begin Web Test
Test Teardown       End Web Test

*** Keywords ***
Begin Web Test
    Open Browser                    about:blank     chrome
    Set Selenium Speed              1
    Maximize Browser Window
    Load Page


Load Page
     Go To                          http://rental31.infotiv.net/

End Web Test
        Close Browser

That user is in car selection page
        Click Button                id:continue
user is not login
        Wait until Element is visible       id:login
user bok a car
        Click Element                xpath://*[@id="bookQ7pass5"]
error messege should show
        Alert should be present     text=You need to be logged in to continue.

*** Test Cases ***
User can access webbpage
        [Documentation]             This is test for access webbpage http://rental31.infotiv.net/
        [Tags]                      Access webbpage
        Wait until page contains       Infotiv Car Rental

User login funktion valid info in Header page
           [Documentation]              This is a test for login funktion with valid info
           [Tags]                       Login funktion with valid login
            Input text                  id:email        mohammedtikabo@live.se
            Input Password              id:password      Mt091113
            Click Button                id:login
            Wait until page contains     You are signed in as Mohammed

User login funktion with invalid Password in Header page
           [Documentation]              This is a test for funktion with invalid Password
           [Tags]                       Login funktion with invalid login
            Input text                  id:email        mohammedtikabo@live.se
            Input Password              id:password      Mt091112
            Click Button                id:login
            Wait until page contains     Wrong e-mail or password

Test invalid boking date Date Selection page
         [Documentation]              This is a test for funktion with invalid date
         [Tags]                       Boking date
         Input text                   id:end         05-24
         Click Button                 id:continue
         Wait until Element is visible        css:#end:invalid


Test for car selection without login in Car Selection page
      [Documentation]              This is a test for car selection without login
      [Tags]                        Car selection without login
      Given That user is in car selection page
      And user is not login
      When user bok a car
      Then error messege should show

Test for boking car
        [Documentation]  This is a test for car boking
        [Tags]           Boking
        Input text                  id:email        mohammedtikabo@live.se
        Input Password              id:password      Mt091113
        Click Button                id:login
        Click Button                 id:continue
        Wait until page contains      What would you like to drive?
        Click Element                xpath://*[@id="bookQ7pass5"]
        Wait until page contains     Confirm booking of
        Input Text                   id:cardNum  1111111111111111
        Input text                    id:fullName  Mohammed Tikabo
        Select from list by label       xpath://select[@title="Month"]   5
        Select from list by label       xpath://select[@title="Year"]   2020
        Input text                    id:cvc  000
        Click Button                 id:confirm
        Wait until page contains       is now ready for pickup
        Click Button                    id:mypage
        Wait until page contains        My bookings
        Click Button                    id:unBook1
        Handle Alert                    action=ACCEPT
        Wait until page contains         has been Returned
