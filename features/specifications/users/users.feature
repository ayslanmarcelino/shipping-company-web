# frozen_string_literal: true

#language: pt

@usuarios

Funcionalidade: Visualizar usuários cadastrados na plataforma

  COMO um usuário master ou proprietário
  EU QUERO acessar a tela de usuários
  PARA visualizar os usuários cadastrados na plataforma

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

  @apagar_usuarios_como_proprietario

  Cenário: Visualizar usuários cadastrados
    Dado que realizo login na aplicação como usuário proprietário
    E tiver "3" usuários cadastrados
    Quando clicar no menu Usuários
    E verificar a quantidade de usuários cadastrados como proprietário
    E clicar no botão de deletar usuário
    E retornar o modal com a seguinte mensagem "Você tem certeza que deseja excluir o usuário"
    E clicar em OK
    E o sistema retornar a seguinte mensagem "Usuário excluído com sucesso."
    Então o usuário deve ser excluído

  @apagar_usuarios_como_master

  Cenário: Visualizar usuários cadastrados
    Dado que realizo login na aplicação como usuário master
    E tiver "3" usuários cadastrados
    Quando clicar no menu Usuários
    E verificar a quantidade de usuários cadastrados como master
    E clicar no botão de deletar usuário
    E retornar o modal com a seguinte mensagem "Você tem certeza que deseja excluir o usuário"
    E clicar em OK
    E o sistema retornar a seguinte mensagem "Usuário excluído com sucesso."
    Então o usuário deve ser excluído

  @visualizar_detalhes_usuario_como_proprietario

  Cenário: Visualizar detalhes do usuário cadastrado
    Dado que realizo login na aplicação como usuário proprietário
    E tiver "3" usuários cadastrados
    Quando clicar no menu Usuários
    E clicar no botão de visualizar detalhes do usuário
    E for redirecionado para a tela de detalhes do usuário
    Então o sistema deve retornar todos os dados do usuário
