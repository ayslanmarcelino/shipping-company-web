# frozen_string_literal: true

#language: pt

@editar_regra_de_usuario_como_master

Funcionalidade: Editar usuários cadastrados na plataforma como master

  COMO um usuário master
  EU QUERO acessar a tela de regras de usuário
  PARA editar as regras de usuário cadastradas na plataforma

  Contexto: Acessar tela de edição de regra de usuário
    Dado que realizo login na aplicação como usuário 'master'
    E tiver '3' regras de usuário do tipo 'operational' cadastradas
    Quando clicar no menu Regras de usuário
    E clicar no botão de 'edit' em regra de usuário
    E for redirecionado para a tela de editar regras de usuário

  @editar_regra_de_usuario_como_master_com_sucesso

  Cenário: Editar regra de usuário como master com sucesso
    E atualizar tipo de regra de usuário
    E clicar em Editar regra de usuário
    E retornar o modal com a seguinte mensagem 'Regra de usuário atualizada com sucesso.'
    E clicar em OK
    E a regra de usuário for atualizada
    Então quero visualizar a regra de usuário atualizada como master

  @editar_regra_de_usuario_como_master_sem_preencher_nova_regra

  Cenário: Editar regra de usuário como master sem preencher nova regra
    E remover o tipo de regra de usuário
    E clicar em Editar regra de usuário
    Então o sistema deve retornar os seguintes valores da tabela
      | Regra não pode ficar em branco |

  @editar_regra_de_usuario_como_master_sem_preencher_empresa

  Cenário: Editar regra de usuário como master sem preencher empresa
    E remover a empresa da regra de usuário
    E clicar em Editar regra de usuário
    Então o sistema deve retornar os seguintes valores da tabela
      | Empresa é obrigatório(a) |

  @editar_regra_de_usuario_como_master_sem_preencher_usuario

  Cenário: Editar regra de usuário como master sem preencher usuário
    E remover o usuário da regra de usuário
    E clicar em Editar regra de usuário
    Então o sistema deve retornar os seguintes valores da tabela
      | Usuário é obrigatório(a) |

  @editar_regra_de_usuario_como_master_com_regra_ja_existente

  Cenário: Editar regra de usuário como master com regra já existente
    E tiver a regra de usuário 'financial' no usuário da última regra criada
    E atualizar tipo de regra de usuário já existente no usuário
    E clicar em Editar regra de usuário
    Então o sistema deve retornar os seguintes valores da tabela
      | Regra já está em uso |
