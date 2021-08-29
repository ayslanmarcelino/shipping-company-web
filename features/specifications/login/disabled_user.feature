# frozen_string_literal: true

#language: pt

@login_usuario_desativado

Funcionalidade: Realizar Login com usuário desativado

  COMO um usuário desativado
  EU QUERO tentar realizar login na aplicação
  PARA visualizar mensagem de erro ao tentar acessar

  Contexto: Acessar a página de login
    Dado que acesso a página de login da aplicação

  @login_com_usuario_desativado

  Cenário: Realizar login com usuário desativado
    E tenha um usuário desativado
    Quando preencher os dados corretamente para logar
    E clicar no botão de login
    Então o sistema deve retornar a seguinte mensagem "Sua conta está inativa. Para mais informações, entre em contato com o administrador da empresa."
