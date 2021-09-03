# frozen_string_literal: true

#language: pt

@login_empresa_desativada

Funcionalidade: Realizar Login com empresa desativada

  COMO um usuário com empresa desativada
  EU QUERO tentar realizar login na aplicação
  PARA visualizar mensagem de erro ao tentar acessar

  Contexto: Acessar a página de login
    Dado que acesso a página de login da aplicação

  @login_com_empresa_desativada

  Cenário: Realizar login com sucesso com empresa desativada
    E tenha um usuário com empresa desativada
    Quando preencher os dados corretamente para logar
    E clicar no botão de login
    Então o sistema deve retornar a seguinte mensagem "Sua empresa está inativa. Para mais informações, entre em contato com o suporte."
