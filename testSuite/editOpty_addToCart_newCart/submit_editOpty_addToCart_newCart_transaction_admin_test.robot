*** Settings ***
Resource          ../../resources.robot
Resource          ../../PageObject/login_pages.robot
Resource          ../../PageObject/menu_pages.robot
Resource          ../../PageObject/home_pages.robot
Resource          ../../PageObject/detail_product_pages.robot
Resource          ../../PageObject/detailTransaksi_pages.robot
Resource          ../../PageObject/daftarTransaksi_semuaPesanan_pages.robot
Resource          ../../PageObject/cms/loginCMS_pages.robot
Resource          ../../PageObject/cms/homeCMS_pages.robot
Resource          ../../PageObject/cms/opportunities_pages.robot
Resource          ../../PageObject/cms/quotation_pages.robot
# Test Setup        Open Main Page Using Chrome Browser

*** Variables ***
${SKU_NUMBER}        SKU00717707
${CATATANTRANSAKSI}   SADASDASasda
${EMAIL_REQUESTOR}    a.parentadmin@grr.la
# ${EMAIL_APPROVER}     a.approver@grr.la
${PASSWORD}           Bhinneka321
${UNIT_BISNIS}        UB2 Requestor
${SELECTALL}          Select All
${TEXTAREA}           SADSAsadsaad asda asdsad
${OPTYNAME}             dasdas
*** Test Cases ***
Create Transaction Admin New Cart Test
    [Timeout]       10 minute
    [Template]    Create Transaction Admin New Cart Get Opty
    [Teardown]    Close Browser
    #SearchData           catatan trx                  email requestor        password              Opty name
    ${SKU_NUMBER}         ${CATATANTRANSAKSI}        ${EMAIL_REQUESTOR}      ${PASSWORD}            ${OPTYNAME}
    # ${SKU_NUMBER}         ${CATATANTRANSAKSI}        a.admin@grr.la             ${PASSWORD}            ${OPTYNAME}
    # ${SKU_NUMBER}         ${CATATANTRANSAKSI}        a.parentchild@grr.la      ${PASSWORD}            ${OPTYNAME}

# Send Quotation From CMS Test
#     [Timeout]       10 minute
#     [Template]    Send Quotation From CMS
#     [Teardown]    Close Browser
#     #Select drop list       textarea
#     ${SELECTALL}            ${TEXTAREA}
#
# Buy Product From CF Test
#     [Timeout]       10 minute
#     [Template]    Buy Product From CF
#     [Teardown]    Close Browser
#     # email requestor        password          textArea
#     ${EMAIL_REQUESTOR}      ${PASSWORD}       ${TEXTAREA}
#
#
# Generate SO From CMS Test
#     [Timeout]       10 minute
#     [Template]      Generate SO From CMS
#     [Teardown]      Close Browser
#     #Select All
#     ${SELECTALL}
*** Keywords ***
Create Transaction Admin New Cart Get Opty
        [Arguments]          ${SKU_NUMBER}         ${CATATANTRANSAKSI}        ${EMAIL_REQUESTOR}      ${PASSWORD}            ${OPTYNAME}
        GIVEN Open Main Page Using Chrome Browser
        And Home Page To Login Email Page
        And Login Account Requestor Success      ${EMAIL_REQUESTOR}      ${PASSWORD}
        And Open Detail Page After Search SKU           ${SKU_NUMBER}
        And Add To Cart Product
        And List Transaction Opened Without Unit Bisnis
        And List First Transaction Selected
        WHEN Detail Transaksi Opened
        And Update Opty From Page Detail Transaction    ${OPTYNAME}
        And Click Submit Button From Detail Transaksi
        And Input Tambahkan Catatan Field     ${opty_number}
        And Click Buat Order Button
        THEN Message Success Buat Order



Send Quotation From CMS
       [Arguments]             ${SELECTALL}         ${TEXTAREA}
       GIVEN Open Main Page CMS Using Chrome Browser
       And Login Account CMS Success
       And Home Pages CMS Opened
       And Click Menu Opportunities
       And Open Quotation Pages From Opportunities   ${opty_number}               ${SELECTALL}
       And Open Quotation
       WHEN Click Button Send Quatation
       And Pop Up Send Quatation Input Notes     ${TEXTAREA}
       And Pop Up Send Quatation Click Button Send Quatation
       THEN Send Quation Success Message


Buy Product From CF
      [Arguments]               ${EMAIL_REQUESTOR}      ${PASSWORD}            ${TEXTAREA}
      GIVEN Open Main Page Using Chrome Browser
      And Home Page To Login Email Page
      And Login Account Requestor Success      ${EMAIL_REQUESTOR}      ${PASSWORD}
      And Click Button Menu Transaksi
      And Klik Tab Semua Pesanan
      And Input Text Search Field Tab Semua Pesanan     ${opty_number}
      And List First Transaction Selected
      WHEN Detail Transaksi Opened
      And Click Beli Button From CF
      And Input Tambahkan Catatan Nego Field       ${TEXTAREA}
      And Click Beli Button From CF From Pop Up Order Buy
      THEN Status Approval requestor



Generate SO From CMS
      [Arguments]             ${SELECTALL}
      GIVEN Open Main Page CMS Using Chrome Browser
      And Login Account CMS Success
      And Home Pages CMS Opened
      And Click Menu Opportunities
      And Open Quotation Pages From Opportunities   ${opty_number}               ${SELECTALL}
      And Open Quotation
      WHEN Click Generate SO Button
      THEN Send Quation Success Message
