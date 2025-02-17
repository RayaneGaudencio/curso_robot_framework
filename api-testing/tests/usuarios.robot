*** Settings ***
Resource    ../resource/usuarios.resource


*** Variables ***


*** Test Cases ***

Cenário 1: Cadastrar um novo usuário com sucesso na ServeRest
    Criar um usuário novo
    Cadastrar o usuário criado na ServeRest    ${EMAIL_TESTE}    status_code_desejado=201
    Confere se o usuario foi cadastrado

Cenário 2: Cadastrar um usuário já existente
    Criar um usuário novo
    Cadastrar o usuário criado na ServeRest    ${EMAIL_TESTE}    status_code_desejado=201
    Repetir cadadastro usuario
    Verifica resultado da API

Cenário 3: Consulta os dados de um novo usuário
    Criar um usuário novo
    Cadastrar o usuário criado na ServeRest    ${EMAIL_TESTE}    status_code_desejado=201
    Consulta os dados do novo usuário
    Confere os dados retornados do usuario