*** Settings ***
Documentation       Suite description

Library     SeleniumLibrary

*** Variables ***
${browser}  Chrome
${url}      https://www.blazedemo.com

###  Inicio e Fim  ####
#est Setup      open browser    ${url} ${browser}
#Test Teardown   close browser


*** Test Cases ***
Compra de Passagem
    [Tags]      Regressao
    Dado que acesso o site blazedemo
    Quando seleciono a origem como "São Paolo"
    E o destino como "London"
    E clico no botao Find Flights
    Entao exibe uma lista de voos para o trecho desejado
    Quando seleciono o primeiro voo disponivel
    E preencho o primeiro nome como "Juca"
    E seleciono a bandeira como "American Express"
    E marco a opcao Remember
    E clico em Purchase Flight
    Entao exibe a mansagem de obrigado
    E o valor como "555 USD"
    Feche o browser



*** Keywords ***
Dado que acesso o site blazedemo
    open browser    ${url}  ${browser}
    Maximize Browser Window
    wait until element is visible    xpath = //h1       30000ms

Quando seleciono a origem como "${origem}"
    set test variable    ${origem}
    select from list by label   name = fromPort     ${origem}

E o destino como "${destino}"
    set test variable    ${destino}
    select from list by label   name = toPort     ${destino}

E clico no botao Find Flights
    click button     class = btn.btn-primary

Entao exibe uma lista de voos para o trecho desejado
    wait until element is visible    xpath = //h3   30000ms
    element should contain           xpath = //h3   Flights from ${origem} to ${destino}

Quando seleciono o primeiro voo disponivel
    click button        class = btn.btn-small


E preencho o primeiro nome como "${nome}"
    wait until element is enabled       id = inputName
    input text                          id = inputName      ${nome}

E seleciono a bandeira como "${bandeira}"
    select from list by label       id = cardType       ${bandeira}

E marco a opcao Remember
    select checkbox     id = rememberMe

E clico em Purchase Flight
    click button        class = btn.btn-primary

Entao exibe a mansagem de obrigado
    wait until element is visible       xpath = //h1
    element should contain              xpath = //h1                    Thank you for your purchase today!

E o valor como "${preco}"
    element should contain              xpath = //tbody/tr[3]/td[2]     ${preco}


Feche o browser
    Close Browser

