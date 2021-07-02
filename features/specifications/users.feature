# frozen_string_literal: true

#language: pt

@usuarios

Funcionalidade: Manipular usuários cadastrados na plataforma

  COMO um usuário master ou proprietário
  EU QUERO acessar a tela de usuários
  PARA manipular os usuários cadastrados na plataforma

  @visualizar_usuarios_como_proprietario

  Cenário: Visualizar usuários cadastrados
    Dado que realizo login na aplicação como usuário proprietário
    E tiver "3" usuários cadastrados
    Quando clicar no menu Usuários
    Então quero visualizar a página de usuários como usuário proprietário

  @visualizar_usuarios_como_master

  Cenário: Visualizar usuários cadastrados
    Dado que realizo login na aplicação como usuário master
    E tiver "3" usuários cadastrados
    Quando clicar no menu Usuários
    Então quero visualizar a página de usuários como usuário master

  @criar_usuario_como_proprietario

  Cenário: Criar usuário como proprietário com sucesso
    Dado que realizo login na aplicação como usuário proprietário
    Quando clicar no menu Usuários
    E clicar no botão de novo usuário
    E preencher todos os dados solicitados para novo usuário
    E clicar em Criar novo usuário
    E o sistema retornar a seguinte mensagem "Usuário cadastrado com sucesso."
    Então quero visualizar o usuário criado como proprietário

  @criar_usuario_como_master

  Cenário: Criar usuário como master com sucesso
    Dado que realizo login na aplicação como usuário master
    Quando clicar no menu Usuários
    E clicar no botão de novo usuário
    E preencher todos os dados solicitados para novo usuário
    E clicar em Criar novo usuário
    E o sistema retornar a seguinte mensagem "Usuário cadastrado com sucesso."
    Então quero visualizar o usuário criado como master
