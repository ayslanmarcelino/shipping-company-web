# frozen_string_literal: true

#language: pt

@usuarios

Funcionalidade: Visualizar usuários cadastrados na plataforma

  COMO um usuário master ou proprietário
  EU QUERO acessar a tela de usuários
  PARA visualizar os usuários cadastrados na plataforma

  @visualizar_usuarios_como_proprietario

  Cenário: Visualizar usuários cadastrados
    Dado que realizo login na aplicação como usuário "owner"
    E tiver "3" usuários cadastrados
    Quando clicar no menu Usuários
    Então quero visualizar a página de usuários como usuário proprietário

  @visualizar_usuarios_como_master

  Cenário: Visualizar usuários cadastrados
    Dado que realizo login na aplicação como usuário "master"
    E tiver "3" usuários cadastrados
    Quando clicar no menu Usuários
    Então quero visualizar a página de usuários como usuário master

  @apagar_usuarios_como_proprietario

  Cenário: Visualizar usuários cadastrados
    Dado que realizo login na aplicação como usuário "owner"
    E tiver "3" usuários cadastrados
    Quando clicar no menu Usuários
    E verificar a quantidade de usuários cadastrados no sistema
    E clicar no botão de "delete" usuário
    E retornar o modal com a seguinte mensagem "Você tem certeza que deseja excluir o usuário"
    E clicar em OK
    E o sistema retornar a seguinte mensagem "Usuário excluído com sucesso."
    Então o usuário deve ser excluído

  @apagar_usuarios_como_master

  Cenário: Visualizar usuários cadastrados
    Dado que realizo login na aplicação como usuário "master"
    E tiver "3" usuários cadastrados
    Quando clicar no menu Usuários
    E verificar a quantidade de usuários cadastrados no sistema
    E clicar no botão de "delete" usuário
    E retornar o modal com a seguinte mensagem "Você tem certeza que deseja excluir o usuário"
    E clicar em OK
    E o sistema retornar a seguinte mensagem "Usuário excluído com sucesso."
    Então o usuário deve ser excluído

  @visualizar_detalhes_usuario_como_proprietario

  Cenário: Visualizar detalhes do usuário cadastrado
    Dado que realizo login na aplicação como usuário "owner"
    E tiver "3" usuários cadastrados
    Quando clicar no menu Usuários
    E clicar no botão de "show" usuário
    E for redirecionado para a tela de detalhes do usuário
    Então o sistema deve retornar todos os dados do usuário

  @visualizar_detalhes_usuario_como_master

  Cenário: Visualizar detalhes do usuário cadastrado
    Dado que realizo login na aplicação como usuário "master"
    E tiver "3" usuários cadastrados
    Quando clicar no menu Usuários
    E clicar no botão de "show" usuário
    E for redirecionado para a tela de detalhes do usuário
    Então o sistema deve retornar todos os dados do usuário

  @deletar_usuario_dentro_de_detalhes_como_proprietario

  Cenário: Visualizar detalhes do usuário cadastrado
    Dado que realizo login na aplicação como usuário "owner"
    E tiver "3" usuários cadastrados
    Quando clicar no menu Usuários
    E verificar a quantidade de usuários cadastrados no sistema
    E clicar no botão de "show" usuário
    E for redirecionado para a tela de detalhes do usuário
    E clicar no botão de "delete" usuário
    E retornar o modal com a seguinte mensagem "Você tem certeza que deseja excluir o usuário"
    E clicar em OK
    E o sistema retornar a seguinte mensagem "Usuário excluído com sucesso."
    Então o usuário deve ser excluído

  @deletar_usuario_dentro_de_detalhes_como_master

  Cenário: Visualizar detalhes do usuário cadastrado
    Dado que realizo login na aplicação como usuário "master"
    E tiver "3" usuários cadastrados
    Quando clicar no menu Usuários
    E verificar a quantidade de usuários cadastrados no sistema
    E clicar no botão de "show" usuário
    E for redirecionado para a tela de detalhes do usuário
    E clicar no botão de "delete" usuário
    E retornar o modal com a seguinte mensagem "Você tem certeza que deseja excluir o usuário"
    E clicar em OK
    E o sistema retornar a seguinte mensagem "Usuário excluído com sucesso."
    Então o usuário deve ser excluído

  @editar_usuario_dentro_de_detalhes_como_proprietario

  Cenário: Visualizar detalhes do usuário cadastrado
    Dado que realizo login na aplicação como usuário "owner"
    E tiver "3" usuários cadastrados
    Quando clicar no menu Usuários
    E clicar no botão de "show" usuário
    E for redirecionado para a tela de detalhes do usuário
    E clicar no botão de "edit" usuário
    Então o sistema deverá redirecionar para a página de edição de usuário

  @editar_usuario_dentro_de_detalhes_como_master

  Cenário: Visualizar detalhes do usuário cadastrado
    Dado que realizo login na aplicação como usuário "master"
    E tiver "3" usuários cadastrados
    Quando clicar no menu Usuários
    E clicar no botão de "show" usuário
    E for redirecionado para a tela de detalhes do usuário
    E clicar no botão de "edit" usuário
    Então o sistema deverá redirecionar para a página de edição de usuário
