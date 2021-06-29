# frozen_string_literal: true

Dado('que acesso a página de login da aplicação') do
  visit '/users/sign_in'
end

Dado('tenha um usuário operacional') do
  @user = FactoryBot.create(:user)
  @user_role = FactoryBot.create(:user_role, kind_cd: :operational, user: @user)
end

Quando('preencher os dados corretamente para logar') do
  find_by_id('user_email').set(@user.email)
  find_by_id('user_password').set(@user.password)
end

Quando('clicar no botão de login') do
  find('.login-btn').click
end

Quando('for redirecionado para a página inicial da aplicação') do
  page.has_title?(@user.enterprise.fantasy_name)
  expect(page).to have_current_path('/')
end

Então('quero visualizar o menu disponível para o usuário operacional') do
  dashboard_menu = find_by_id('dashboard').present?
  truckloads_menu = find_by_id('truckloads').present?
  ctes_menu = find_by_id('ctes').present?
  clients_menu = find_by_id('clients').present?
  drivers_menu = find_by_id('drivers').present?

  expect(dashboard_menu).to eq true
  expect(truckloads_menu).to eq true
  expect(ctes_menu).to eq true
  expect(clients_menu).to eq true
  expect(drivers_menu).to eq true
end

Então('quero visualizar o menu disponível para o usuário proprietário') do
  dashboard_menu = find_by_id('dashboard').present?
  truckloads_menu = find_by_id('truckloads').present?
  ctes_menu = find_by_id('ctes').present?
  clients_menu = find_by_id('clients').present?
  drivers_menu = find_by_id('drivers').present?
  users_menu = find_by_id('users').present?
  user_roles_menu = find_by_id('user_roles').present?

  expect(dashboard_menu).to eq true
  expect(truckloads_menu).to eq true
  expect(ctes_menu).to eq true
  expect(clients_menu).to eq true
  expect(drivers_menu).to eq true
  expect(users_menu).to eq true
  expect(user_roles_menu).to eq true
end

Então('quero visualizar o menu disponível para o usuário master') do
  dashboard_menu = find_by_id('dashboard').present?
  truckloads_menu = find_by_id('truckloads').present?
  ctes_menu = find_by_id('ctes').present?
  clients_menu = find_by_id('clients').present?
  drivers_menu = find_by_id('drivers').present?
  users_menu = find_by_id('users').present?
  user_roles_menu = find_by_id('user_roles').present?
  enterprises_menu = find_by_id('enterprises').present?

  expect(dashboard_menu).to eq true
  expect(truckloads_menu).to eq true
  expect(ctes_menu).to eq true
  expect(clients_menu).to eq true
  expect(drivers_menu).to eq true
  expect(users_menu).to eq true
  expect(user_roles_menu).to eq true
  expect(enterprises_menu).to eq true
end

Dado('tenha um usuário proprietário') do
  @user = FactoryBot.create(:user)
  @user_role = FactoryBot.create(:user_role, kind_cd: :owner, user: @user)
end

Dado('tenha um usuário master') do
  @user = FactoryBot.create(:user)
  @user_role = FactoryBot.create(:user_role, kind_cd: :master, user: @user)
end

Quando('preencher os dados incorretamente para logar') do
  find_by_id('user_email').set(Faker::Internet.email)
  find_by_id('user_password').set('1234567890')
end

Então('quero visualizar a mensagem de que o login falhou') do
  expect(page).to have_content('E-mail e/ou senha inválido(s)')
end
