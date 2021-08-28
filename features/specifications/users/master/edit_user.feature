# frozen_string_literal: true

#language: pt

@editar_usuario_como_master

Funcionalidade: Editar usuários cadastrados na plataforma como master

  COMO um usuário master
  EU QUERO acessar a tela de usuários
  PARA editar os usuários cadastrados na plataforma

  @editar_usuario_como_master_com_sucesso

  Cenário: Criar usuário como proprietário com sucesso
    Dado que realizo login na aplicação como usuário "master"
    E tiver "3" usuários cadastrados
    Quando clicar no menu Usuários
    E clicar no botão de "edit" usuário
    E for redirecionado para a tela de editar usuário
    Então quero visualizar a tela de editar usuário
