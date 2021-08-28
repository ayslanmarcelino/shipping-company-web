# frozen_string_literal: true

#language: pt

@login_master

Funcionalidade: Realizar Login como master

  COMO um usuário master
  EU QUERO realizar login na aplicação
  PARA acessar as funcionalidades disponíveis

  Contexto: Acessar a página de login
    Dado que acesso a página de login da aplicação

  @login_com_sucesso_como_usuario_master

  Cenário: Realizar login com sucesso com usuário master
    E tenha um usuário "master"
    Quando preencher os dados corretamente para logar
    E clicar no botão de login
    E for redirecionado para a página inicial da aplicação
    E o sistema retornar a seguinte mensagem "Login efetuado com sucesso."
    Então quero visualizar o menu disponível para o usuário master

  @login_com_usuario_e_senha_incorretos

  Cenário: Realizar login com usuário e/ou senha incorreto(s)
    Quando preencher os dados incorretamente para logar
    E clicar no botão de login
    Então o sistema deve retornar a seguinte mensagem "E-mail e/ou senha inválido(s)"
