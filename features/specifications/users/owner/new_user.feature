# frozen_string_literal: true

#language: pt

@criar_usuario_como_proprietario

Funcionalidade: Criar usuários na plataforma como proprietário

  COMO um usuário proprietário
  EU QUERO acessar a tela de usuários
  PARA criar os usuários na plataforma

  Contexto: Acessar a página de novo usuário
    Dado que realizo login na aplicação como usuário 'owner'
    Quando clicar no menu Usuários
    E clicar no botão de novo usuário
    E for redirecionado para a tela de novo usuário

  @criar_usuario_como_proprietario_com_sucesso

  Cenário: Criar usuário como proprietário com sucesso
    E preencher todos os dados solicitados para novo usuário
    E clicar em Criar novo usuário
    E o sistema retornar a seguinte mensagem 'Usuário cadastrado com sucesso.'
    Então quero visualizar o usuário criado como proprietário

  @criar_usuario_como_proprietario_apenas_com_dados_obrigatorios

  Cenário: Criar usuário como proprietário apenas com dados obrigatórios
    E preencher apenas dados obrigatórios para novo usuário
    E clicar em Criar novo usuário
    E o sistema retornar a seguinte mensagem 'Usuário cadastrado com sucesso.'
    Então quero visualizar o usuário criado como proprietário

  @criar_usuario_como_proprietario_sem_preencher_dados_obrigatorios
    Cenário: Criar usuário como proprietário sem preencher dados obrigatórios
      E clicar em Criar novo usuário
      Então o sistema deve retornar os seguintes valores da tabela
        | E-mail não pode ficar em branco        |
        | Senha não pode ficar em branco         |
        | Empresa é obrigatório(a)               |
        | Primeiro nome não pode ficar em branco |
        | Último nome não pode ficar em branco   |

  @criar_usuario_como_proprietario_com_dados_obrigatorios_e_apenas_cep
    Cenário: Criar usuário como proprietário com dados obrigatórios e apenas CEP
      E preencher apenas dados obrigatórios para novo usuário e apenas CEP
      E clicar em Criar novo usuário
      Então o sistema deve retornar os seguintes valores da tabela
        | Bairro não pode ficar em branco     |
        | Logradouro não pode ficar em branco |
        | Cidade não pode ficar em branco     |
        | Estado não pode ficar em branco     |
        | País não pode ficar em branco       |

  @criar_usuario_como_proprietario_com_cpf_ja_existente
    Cenário: Criar usuário como proprietário com dados obrigatórios e CPF já existente
      E preencher todos os dados solicitados para novo usuário com CPF já cadastrado
      E clicar em Criar novo usuário
      Então o sistema deve retornar os seguintes valores da tabela
        | CPF já está em uso |

  @criar_usuario_como_proprietario_com_email_ja_existente
    Cenário: Criar usuário como proprietário com dados obrigatórios e e-mail já existente
      E preencher todos os dados solicitados para novo usuário com e-mail já cadastrado
      E clicar em Criar novo usuário
      Então o sistema deve retornar os seguintes valores da tabela
        | E-mail já está em uso |
