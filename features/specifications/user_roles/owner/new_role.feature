# frozen_string_literal: true

#language: pt

@criar_regra_de_usuario_como_proprietario

Funcionalidade: Criar regras de usuário na plataforma como master

  COMO um usuário proprietário
  EU QUERO acessar a tela de regras de usuário
  PARA criar as regras de usuário na plataforma

  Contexto: Acessar tela de criar nova regra de usuário
    Dado que realizo login na aplicação como usuário 'owner'
    E tiver '2' usuários cadastrados
    Quando clicar no menu Regras de usuário
    E clicar no botão de nova regra de usuário
    E for redirecionado para a tela de nova regra de usuário

  @criar_regra_de_usuario_como_proprietario_com_sucesso

  Cenário: Criar regra de usuário como proprietário com sucesso
    E preencher todos os dados solicitados para nova regra de usuário
    E clicar em Criar nova regra de usuário
    E o sistema retornar a seguinte mensagem 'Regra de usuário cadastrada com sucesso.'
    Então quero visualizar a regra de usuário criada como proprietário
  
  @criar_regra_de_usuario_como_proprietario_sem_preencher_dados_obrigatorios

  Cenário: Criar regra de usuário como proprietário sem preencher dados obrigatórios
    E clicar em Criar nova regra de usuário
    Então o sistema deve retornar os seguintes valores da tabela
      | Regra não pode ficar em branco |
      | Empresa é obrigatório(a)       |
      | Usuário é obrigatório(a)       |

  @criar_regra_de_usuario_como_proprietario_com_regra_ja_existente

  Cenário: Criar regra de usuário como proprietário com regra já existente
    E preencher todos os dados solicitados para nova regra de usuário com regra já cadastrada
    E clicar em Criar nova regra de usuário
    Então o sistema deve retornar os seguintes valores da tabela
      | Regra já está em uso |

  @criar_regra_de_usuario_como_proprietario_com_tipo_de_regra_existente_com_usuario_diferente

  Cenário: Criar regra de usuário como proprietário com tipo de regra já existente e usuário diferente
    E preencher todos os dados solicitados para nova regra de usuário com regra já cadastrada com usuário diferente
    E clicar em Criar nova regra de usuário
    E o sistema retornar a seguinte mensagem 'Regra de usuário cadastrada com sucesso.'
    Então quero visualizar a regra de usuário criada como proprietário
