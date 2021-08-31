# frozen_string_literal: true

#language: pt

@usuarios_como_monitoramento

Funcionalidade: Visualizar usuários cadastrados na plataforma como monitoramento

  COMO um usuário monitoramento
  EU QUERO acessar a tela de usuários
  PARA tentar manipular os usuários cadastrados na plataforma

  Contexto: Logar no sistema como usuário monitoramento
    Dado que realizo login na aplicação como usuário 'monitoring'

  @visualizar_usuarios_como_monitoramento

  Cenário: Visualizar usuários cadastrados
    E tiver '3' usuários cadastrados
    Quando digitar a URL de admins de 'index' 'users'
    Então o sistema deve retornar a seguinte mensagem 'Você não possui permissão para acessar esta página'

  @criar_usuarios_como_monitoramento

  Cenário: Acessar tela de criar usuário como monitoramento
    Quando digitar a URL de admins de 'new' 'users'
    Então o sistema deve retornar a seguinte mensagem 'Você não possui permissão para acessar esta página'

  @atualizar_usuarios_como_monitoramento

  Cenário: Acessar tela de atualizar usuário como monitoramento
    E tiver '3' usuários cadastrados
    Quando digitar a URL de admins de atualizar 'users'
    Então o sistema deve retornar a seguinte mensagem 'Você não possui permissão para acessar esta página'

  @visualizar_detalhes_usuario_como_monitoramento

  Cenário: Acessar tela de detalhes do usuário cadastrado
    Dado que realizo login na aplicação como usuário 'monitoring'
    E tiver '3' usuários cadastrados
    Quando digitar a URL de admins de detalhes 'users'
    Então o sistema deve retornar a seguinte mensagem 'Você não possui permissão para acessar esta página'
