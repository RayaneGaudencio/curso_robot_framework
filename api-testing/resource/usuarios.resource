*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections


*** Keywords ***
Criar um usuário novo
    ${palavra_aleatoria}    Generate Random String    length=4    chars=[LETTERS]
    ${palavra_aleatoria}    Convert To Lower Case    ${palavra_aleatoria}
    Set Test Variable    ${EMAIL_TESTE}    ${palavra_aleatoria}@emailteste.com

Cadastrar o usuário criado na ServeRest
    [Arguments]    ${email}    ${status_code_desejado} 
    ${body}    Create Dictionary    
    ...    nome=Fulano da Silva    
    ...    email=${email}    
    ...    password=1234    
    ...    administrador=true
    Criar sessão na ServeRest
    ${response}    POST On Session    
    ...    ServeRest    
    ...    /usuarios    json=${body} 
    ...    expected_status=${status_code_desejado}
    IF    ${response.status_code} == 201
        Set Test Variable    ${ID_USUARIO}    ${response.json()["_id"]}
    END
    Set Test Variable    ${RESPOSTA}    ${response.json()}

Criar sessão na ServeRest
    ${headers}    Create Dictionary    accept=application/json    content-type=application/json
    Create Session    ServeRest    https://serverest.dev    ${headers}

Confere se o usuario foi cadastrado
    Dictionary Should Contain Item    ${RESPOSTA}   message    Cadastro realizado com sucesso
    Dictionary Should Contain Key    ${RESPOSTA}    _id

Repetir cadadastro usuario
    Cadastrar o usuário criado na ServeRest    ${EMAIL_TESTE}    status_code_desejado=400

Verifica resultado da API
    Dictionary Should Contain Item    ${RESPOSTA}    message    Este email já está sendo usado

Consulta os dados do novo usuário
    ${resposta_consulta}    GET On Session    alias=ServeRest    url=/usuarios/${ID_USUARIO}
    Set Test Variable    ${DADOS_USUARIO}    ${resposta_consulta.json()}

Confere os dados retornados do usuario
    Dictionary Should Contain Item    ${DADOS_USUARIO}    nome                       Fulano da Silva
    Dictionary Should Contain Item    ${DADOS_USUARIO}    email            ${EMAIL_TESTE}
    Dictionary Should Contain Item    ${DADOS_USUARIO}    password         1234
    Dictionary Should Contain Item    ${DADOS_USUARIO}    administrador    true
    Dictionary Should Contain Item    ${DADOS_USUARIO}    _id              ${ID_USUARIO}
    
