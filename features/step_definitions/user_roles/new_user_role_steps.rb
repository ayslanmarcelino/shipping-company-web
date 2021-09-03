Quando('for redirecionado para a tela de nova regra de usuário') do
  @registered_user_roles_count = User::Role.count
  @form_user_role_page.new_page?

  expect(page).to have_current_path('/user/roles/new')
end

Quando('preencher todos os dados solicitados para nova regra de usuário') do
  @form_user_role_page.select_roles_owner?
  @form_user_role_page.fill_all_fields(@users.last)
end

Quando('clicar em Criar nova regra de usuário') do
  @form_user_role_page.click_new_user_role
end

Então('quero visualizar a regra de usuário criada como proprietário') do
  view_created_user_role
  user_roles_expect_content_owner(@user_roles)

  registered_user_roles_count_after_create = User::Role.count
  expect(registered_user_roles_count_after_create).to eql(@registered_user_roles_count + 1)
end

Então('quero visualizar a regra de usuário criada como master') do
  view_created_user_role
  user_roles_expect_content_master(@user_roles)

  registered_user_roles_count_after_create = User::Role.count
  expect(registered_user_roles_count_after_create).to eql(@registered_user_roles_count + 1)
end

Quando('preencher todos os dados solicitados para nova regra de usuário com regra já cadastrada') do
  @form_user_role_page.fill_existing_role(@last_user_role_before_create)
end

Quando('preencher todos os dados solicitados para nova regra de usuário com regra já cadastrada com usuário diferente') do
  @form_user_role_page.fill_existing_role_with_different_user(@users.last, @last_user_role_before_create)
end

private

def view_created_user_role
  last_user_role_after_create = User::Role.last

  expect(@last_user_role_before_create).not_to eql(last_user_role_after_create)

  @user_roles = []
  @user_roles << @last_user_role_before_create
  @user_roles << last_user_role_after_create
end
