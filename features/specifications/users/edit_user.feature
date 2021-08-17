# frozen_string_literal: true

#language: pt

@editar_usuario

Funcionalidade: Editar usuários cadastrados na plataforma

  COMO um usuário master ou proprietário
  EU QUERO acessar a tela de usuários
  PARA editar os usuários cadastrados na plataforma

  @editar_usuario_como_proprietario_com_sucesso

  Cenário: Criar usuário como proprietário com sucesso
    Dado que realizo login na aplicação como usuário "owner"
    E tiver "3" usuários cadastrados
    Quando clicar no menu Usuários
    E clicar no botão de "edit" usuário
    E for redirecionado para a tela de editar usuário
    Então quero visualizar a tela de editar usuário
