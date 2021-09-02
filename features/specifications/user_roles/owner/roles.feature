# frozen_string_literal: true

#language: pt

@regra_de_usuario_como_proprietario

Funcionalidade: Visualizar regras de usuário cadastradas na plataforma como proprietario

  COMO um usuário proprietario
  EU QUERO acessar a tela de regra de usuário
  PARA visualizar as regras de usuário cadastradas na plataforma

  Contexto: Acessar o menu de regras de usuário
    Dado que realizo login na aplicação como usuário 'owner'
    E tiver '3' regras de usuário cadastradas
    Quando clicar no menu Regras de usuário

  @visualizar_regra_de_usuario_como_proprietario

  Cenário: Visualizar regras de usuário cadastradas
    Então quero visualizar a página de regras de usuário como usuário proprietário

  @apagar_regra_de_usuario_como_proprietario

  Cenário: Apagar regra de usuário
    E verificar a quantidade de regras de usuário cadastrados no sistema
    E clicar no botão de 'delete' em regra de usuário
    E retornar o modal com a seguinte mensagem 'Você tem certeza que deseja excluir a regra de usuário'
    E clicar em OK
    E o sistema retornar a seguinte mensagem 'Regra de usuário excluída com sucesso.'
    Então a regra de usuário deve ser excluída

  @visualizar_editar_regra_de_usuario_como_proprietario

  Cenário: Editar regra de usuário
    E clicar no botão de 'edit' em regra de usuário
    Então o sistema deverá redirecionar para a página de edição de regra de usuário
