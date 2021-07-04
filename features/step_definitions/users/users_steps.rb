Dado('tiver {string} usuários cadastrados') do |times|
  @users = []

  @users << @user
  @users += FactoryBot.create_list(:user, times.to_i, enterprise: @enterprise)
end

Então('quero visualizar a página de usuários como usuário proprietário') do
  @users_page.owner_users_page?

  users_expect_content_owner(@users)
  expect(page).to have_content("#{@user.enterprise.users.count} registros")
end

Então('quero visualizar a página de usuários como usuário master') do
  @users_page.master_users_page?

  users_expect_content_master(@users)
  expect(page).to have_content("#{User.all.count} registros")
end

Quando('verificar a quantidade de usuários cadastrados como proprietário') do
  @users_count = User.where(enterprise: @user.enterprise).count
end

Quando('verificar a quantidade de usuários cadastrados como master') do
  @users_count = User.count
end

Quando('clicar no botão de novo usuário') do
  @users_page.click_new_user
  @new_user_page = NewUserPage.new
  @last_user_before_create = User.last
end

Então('quero visualizar o usuário criado como proprietário') do
  view_created_user
  users_expect_content_owner(@users)
end

Então('quero visualizar o usuário criado como master') do
  view_created_user
  users_expect_content_master(@users)
end

Quando('clicar no botão de deletar usuário') do
  delete_button = find_by_id("delete-user-#{@users.last.id}")

  delete_button.click
end

Quando('retornar o modal com a seguinte mensagem {string}') do |message|
  @general_page = GeneralPage.new
  @general_page.modal?

  expect(page).to have_content(message)
end

Então('o usuário deve ser excluído') do
  users_not_expect_content(@users.last)

  expect(page).to have_content("#{@users_count - 1} registros")
end

private

def users_expect_content_owner(users)
  users.each do |user|
    id = user.id
    full_name = user.person.full_name
    nickname = user.person.nickname
    document_number = user.person.document_number
    email = user.email
    roles = I18n.t(user.all_roles, scope: 'activerecord.attributes.user/role.kinds').join(', ')
    is_active = I18n.t(user.is_active, scope: 'application')
    button_show = find_by_id("show-user-#{user.id}").present?
    button_edit = find_by_id("edit-user-#{user.id}").present?
    button_delete = find_by_id("delete-user-#{user.id}").present?

    expect(page).to have_content(id)
    expect(page).to have_content(full_name)
    expect(page).to have_content(nickname)
    expect(page).to have_content(document_number)
    expect(page).to have_content(email)
    expect(page).to have_content(roles) if roles.present?
    expect(page).to have_content(is_active)
    expect(button_show).to eql(true)
    expect(button_edit).to eql(true)
    expect(button_delete).to eql(true)
  end
end

def users_expect_content_master(users)
  users.each do |user|
    users_expect_content_owner(users)
    enterprise = user.enterprise.company_name

    expect(page).to have_content(enterprise)
  end
end

def view_created_user
  last_user_after_create = User.last

  expect(@last_user_before_create).not_to eql(last_user_after_create)

  @users = []
  @users << @last_user_before_create
  @users << last_user_after_create
end

def users_not_expect_content(user)
  id = user.id
  full_name = user.person.full_name
  nickname = user.person.nickname
  document_number = user.person.document_number
  email = user.email
  roles = I18n.t(user.all_roles, scope: 'activerecord.attributes.user/role.kinds').join(', ')

  expect(page).to have_no_content(id)
  expect(page).to have_no_content(full_name)
  expect(page).to have_no_content(nickname)
  expect(page).to have_no_content(document_number)
  expect(page).to have_no_content(email)
  expect(page).to have_no_content(roles) if roles.present?
end
