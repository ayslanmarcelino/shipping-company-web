Então('o sistema deverá redirecionar para a página de edição de regra de usuário') do
  edit_page
end

Quando('for redirecionado para a tela de editar regras de usuário') do
  edit_page
end

Quando('atualizar tipo de regra de usuário') do
  @form_user_role_page.update_kind_to_operational
end

Quando('clicar em Editar regra de usuário') do
  @form_user_role_page.click_edit_user_role
end

Quando('a regra de usuário for atualizada') do
  updated_user_role = User::Role.last

  expect(@last_user_role_before_update.id).to eq(updated_user_role.id)
  expect(@last_user_role_before_update.kind_cd).not_to eq(updated_user_role.kind_cd)
end

Então('quero visualizar a regra de usuário atualizada como proprietário') do
  user_roles_expect_content_owner(@user_roles)
end

Quando('remover o tipo de regra de usuário') do
  @form_user_role_page.remove_role
end

Quando('remover a empresa da regra de usuário') do
  @form_user_role_page.remove_enterprise
end

Quando('remover o usuário da regra de usuário') do
  @form_user_role_page.remove_user
end

Quando('atualizar tipo de regra de usuário já existente no usuário') do
  @form_user_role_page.update_kind_to_existing(@user_roles.last.user.roles.last)
end

private

def edit_page
  form_user_role_page = FormUserRolePage.new
  editing_user_role_label = "Você está editando a regra de usuário:"
  role = I18n.t(@user_roles.last.kind_cd, scope: 'activerecord.attributes.user/role.kinds')
  user_name = @user_roles.last.user.person.full_name
  full_label = "#{editing_user_role_label} #{role} do(a) #{user_name}"

  form_user_role_page.edit_page?
  expect(page).to have_content(full_label)
  expect(page).to have_current_path("/user/roles/#{@user_roles.last.id}/edit")
end
