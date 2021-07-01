# frozen_string_literal: true

Dado('que acesso a página de login da aplicação') do
  @login_page = LoginPage.new
  @login_page.load

  expect(page).to have_current_path(@login_page.current_path)
end

Dado('tenha um usuário operacional') do
  @enterprise = FactoryBot.create(:enterprise)
  @user = FactoryBot.create(:user, enterprise: @enterprise)
  @user_role = FactoryBot.create(:user_role, kind_cd: :operational, user: @user, enterprise: @enterprise)
end

Quando('preencher os dados corretamente para logar') do
  @login_page.fill_correct_user(@user)
end

Quando('clicar no botão de login') do
  @login_page.click_enter_login
end

Quando('for redirecionado para a página inicial da aplicação') do
  page.has_title?(@user.enterprise.fantasy_name)
  expect(page).to have_current_path('/')
end

Quando('visualizar a mensagem de logado com sucesso') do
  successfully_login_message = 'Login efetuado com sucesso.'

  expect(page).to have_content(successfully_login_message)
end

Então('quero visualizar o menu disponível para o usuário operacional') do
  @menu_page = MenuPage.new

  expect(@menu_page.operational_menu?).to eq true
  expect(page).to have_no_selector('#users')
  expect(page).to have_no_selector('#user_roles')
  expect(page).to have_no_selector('#enterprises')
end

Então('quero visualizar o menu disponível para o usuário proprietário') do
  @menu_page = MenuPage.new

  expect(@menu_page.owner_menu?).to eq true
  expect(page).to have_no_selector('#enterprises')
end

Então('quero visualizar o menu disponível para o usuário master') do
  @menu_page = MenuPage.new

  expect(@menu_page.master_menu?).to eq true
end

Dado('tenha um usuário proprietário') do
  @enterprise = FactoryBot.create(:enterprise)
  @user = FactoryBot.create(:user, enterprise: @enterprise)
  @user_role = FactoryBot.create(:user_role, kind_cd: :owner, user: @user, enterprise: @enterprise)
end

Dado('tenha um usuário master') do
  @enterprise = FactoryBot.create(:enterprise)
  @user = FactoryBot.create(:user, enterprise: @enterprise)
  @user_role = FactoryBot.create(:user_role, kind_cd: :master, user: @user, enterprise: @enterprise)
end

Quando('preencher os dados incorretamente para logar') do
  @login_page.fill_incorrect_user
end

Então('quero visualizar a mensagem de que o login falhou') do
  failed_login_message = 'E-mail e/ou senha inválido(s)'

  expect(page).to have_content(failed_login_message)
end

Dado('que realizo login na aplicação como usuário proprietário') do
  @enterprise = FactoryBot.create(:enterprise)
  @user = FactoryBot.create(:user, enterprise: @enterprise)
  @user_role = FactoryBot.create(:user_role, kind_cd: :owner, user: @user, enterprise: @enterprise)
  @login_page = LoginPage.new
  @menu_page = MenuPage.new

  @login_page.load
  @login_page.fill_correct_user(@user)
  @login_page.click_enter_login
end
