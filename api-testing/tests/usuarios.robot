*** Settings ***
Resource    ../resource/usuarios.resource


*** Variables ***


*** Test Cases ***

Cenário 1: Cadastrar um novo usuário com sucesso na ServeRest
    Cria usuario e cadastra na ServeRest
    Confere se o usuario foi cadastrado

Cenário 2: Cadastrar um usuário já existente
    Cria usuario e cadastra na ServeRest
    Repetir cadadastro usuario
    Verifica resultado da API

Cenário 3: Consulta os dados de um novo usuário
    Cria usuario e cadastra na ServeRest
    Consulta os dados do novo usuário
    Confere os dados retornados do usuario

### Keywords de Auxílio ###
*** Keywords ***

Cria usuario e cadastra na ServeRest
    Criar um usuário novo
    Cadastrar o usuário criado na ServeRest    ${EMAIL_TESTE}    status_code_desejado=201