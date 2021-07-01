Dado('tiver {string} usuários cadastrados') do |times|
  @users = FactoryBot.create_list(:user, times.to_i, enterprise: @enterprise)

  @users << @user
end

Então('quero visualizar a página de usuários como usuário proprietário') do
  @users_page.owner_users_page?

  users_expect_content_owner(@users)
  expect(page).to have_content("#{@user.enterprise.users.count} registros")
end

Então('quero visualizar a página de usuários como usuário master') do
  @users_page.master_users_page?

  users_expect_content_owner(@users)
  users_expect_content_master(@users)
  expect(page).to have_content("#{User.all.count} registros")
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
    expect(page).to have_content(roles)
    expect(page).to have_content(is_active)
    expect(button_show).to eql(true)
    expect(button_edit).to eql(true)
    expect(button_delete).to eql(true)
  end
end

def users_expect_content_master(users)
  users.each do |user|
    enterprise = user.enterprise.company_name

    expect(page).to have_content(enterprise)
  end
end
