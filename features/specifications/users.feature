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
    Então quero visualizar a página de usuários
