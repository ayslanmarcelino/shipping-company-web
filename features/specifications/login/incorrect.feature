# frozen_string_literal: true

#language: pt

@login_incorreto

Funcionalidade: Realizar Login com login e/ou senha incorreto(s)

  COMO um usuário com login e/ou senha incorreto(s)
  EU QUERO realizar login na aplicação
  PARA acessar as funcionalidades disponíveis

  Contexto: Acessar a página de login
    Dado que acesso a página de login da aplicação

  @login_com_usuario_e_senha_incorretos

  Cenário: Realizar login com usuário e/ou senha incorreto(s)
    Quando preencher os dados incorretamente para logar
    E clicar no botão de login
    Então o sistema deve retornar a seguinte mensagem "E-mail e/ou senha inválido(s)"
