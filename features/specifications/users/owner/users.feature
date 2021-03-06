# frozen_string_literal: true

#language: pt

@usuarios_como_proprietario

Funcionalidade: Visualizar usuários cadastrados na plataforma como proprietário

  COMO um usuário proprietário
  EU QUERO acessar a tela de usuários
  PARA visualizar os usuários cadastrados na plataforma

  Contexto: Acessar menu usuários com usuários já cadastrados
    Dado que realizo login na aplicação como usuário 'owner'
    E tiver '3' usuários cadastrados
    Quando clicar no menu Usuários

  @visualizar_usuarios_como_proprietario

  Cenário: Visualizar usuários cadastrados
    Então quero visualizar a página de usuários como usuário proprietário

  @apagar_usuarios_como_proprietario

  Cenário: Visualizar usuários cadastrados
    E verificar a quantidade de usuários cadastrados no sistema
    E clicar no botão de 'delete' usuário
    E retornar o modal com a seguinte mensagem 'Você tem certeza que deseja excluir o usuário'
    E clicar em OK
    E o sistema retornar a seguinte mensagem 'Usuário excluído com sucesso.'
    Então o usuário deve ser excluído

  @visualizar_detalhes_usuario_como_proprietario

  Cenário: Visualizar detalhes do usuário cadastrado
    E clicar no botão de 'show' usuário
    E for redirecionado para a tela de detalhes do usuário
    Então o sistema deve retornar todos os dados do usuário

  @deletar_usuario_dentro_de_detalhes_como_proprietario

  Cenário: Visualizar detalhes do usuário cadastrado
    E verificar a quantidade de usuários cadastrados no sistema
    E clicar no botão de 'show' usuário
    E for redirecionado para a tela de detalhes do usuário
    E clicar no botão de 'delete' usuário
    E retornar o modal com a seguinte mensagem 'Você tem certeza que deseja excluir o usuário'
    E clicar em OK
    E o sistema retornar a seguinte mensagem 'Usuário excluído com sucesso.'
    Então o usuário deve ser excluído

  @editar_usuario_dentro_de_detalhes_como_proprietario

  Cenário: Visualizar detalhes do usuário cadastrado
    E clicar no botão de 'show' usuário
    E for redirecionado para a tela de detalhes do usuário
    E clicar no botão de 'edit' usuário
    Então o sistema deverá redirecionar para a página de edição de usuário
