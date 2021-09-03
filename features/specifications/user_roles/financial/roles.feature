# frozen_string_literal: true

#language: pt

@regras_de_usuario_como_financeiro

Funcionalidade: Visualizar regras de usuário cadastradas na plataforma como financeiro

  COMO um usuário financeiro
  EU QUERO acessar a tela de regras de usuário
  PARA tentar manipular os regras de usuário cadastradas na plataforma

  Contexto: Logar no sistema como usuário financeiro
    Dado que realizo login na aplicação como usuário 'financial'

  @visualizar_regras_de_usuario_como_financeiro

  Cenário: Visualizar regras de usuário cadastradas
    E tiver '3' regras de usuário cadastradas
    Quando digitar a URL de 'index' 'user/roles'
    Então o sistema deve retornar a seguinte mensagem 'Você não possui permissão para acessar esta página.'

  @criar_regras_de_usuario_como_financeiro

  Cenário: Acessar tela de criar usuário como financeiro
    Quando digitar a URL de 'new' 'user/roles'
    Então o sistema deve retornar a seguinte mensagem 'Você não possui permissão para acessar esta página.'

  @atualizar_regras_de_usuario_como_financeiro

  Cenário: Acessar tela de atualizar usuário como financeiro
    E tiver '3' regras de usuário cadastradas
    Quando digitar a URL de atualizar 'user/roles'
    Então o sistema deve retornar a seguinte mensagem 'Você não possui permissão para acessar esta página.'
