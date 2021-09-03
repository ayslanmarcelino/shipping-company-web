Dado('tiver {string} regras de usuário cadastradas') do |times|
  registered_user_roles_count = User::Role.count
  @user_roles = FactoryBot.create_list(:user_role, times.to_i, enterprise: @enterprise)

  registered_user_roles_count_after_create = User::Role.count

  expect(registered_user_roles_count_after_create).to eql(registered_user_roles_count + times.to_i)
end

Dado('tiver {string} regras de usuário do tipo {string} cadastradas') do |times, kind|
  registered_user_roles_count = User::Role.count
  users = FactoryBot.create_list(:user, times.to_i, enterprise: @enterprise)
  @user_roles = []
  users.each do |user|
    @user_roles << FactoryBot.create(:user_role, enterprise: @enterprise, kind: kind, user: user)
  end

  registered_user_roles_count_after_create = User::Role.count

  expect(registered_user_roles_count_after_create).to eql(registered_user_roles_count + times.to_i)
end

Dado('tiver a regra de usuário {string} no usuário da última regra criada') do |role|
  FactoryBot.create(:user_role, user: @user_roles.last.user, kind_cd: role)
end

Então('quero visualizar a página de regras de usuário como usuário proprietário') do
  @user_roles_page.owner_user_roles_page?

  user_roles_expect_content_owner(@user_roles)
end

Quando('verificar a quantidade de regras de usuário cadastrados no sistema') do
  @user_roles_count = User::Role.count
end

Quando('clicar no botão de {string} em regra de usuário') do |action|
  @last_user_role_before_update = @user_roles.last
  button = find_by_id("#{action}-user-role-#{@user_roles.last.id}")

  button.click
end

Então('a regra de usuário deve ser excluída') do
  user_roles_count = User::Role.count
  subtraction_excluded_user_role = @user_roles_count - 1
  has_excluded_user_role_on_db = User::Role.where(id: @user_roles.last.id).present?

  expect(user_roles_count).to eq(subtraction_excluded_user_role)
  expect(has_excluded_user_role_on_db).to eql(false)
end

Quando('clicar no botão de nova regra de usuário') do
  @user_roles_page.click_new_user_role
  @last_user_role_before_create = User::Role.last
end

private

def user_roles_expect_content_owner(user_roles)
  user_roles.each do |role|
    role_id = role.id
    kind = I18n.t(role.kind_cd, scope: 'activerecord.attributes.user/role.kinds')
    user = role.user.person.full_name
    created_at = I18n.l(role.created_at, format: :with_full_hour)
    button_edit = find_by_id("edit-user-role-#{role.id}").present?
    button_delete = find_by_id("delete-user-role-#{role.id}").present?

    expect(page).to have_content(role_id)
    expect(page).to have_content(kind)
    expect(page).to have_content(user)
    expect(page).to have_content(created_at)
    expect(button_edit).to eql(true)
    expect(button_delete).to eql(true)
  end
end
