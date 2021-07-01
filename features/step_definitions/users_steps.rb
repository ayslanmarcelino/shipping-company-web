Dado('tiver {string} usuários cadastrados') do |times|
  @users = FactoryBot.create_list(:user, times.to_i, enterprise: @enterprise)

  @users << @user
end

Então('quero visualizar a página de usuários') do
  @users_page.owner_users_page?

  @users.each do |user|
    id = user.id
    full_name = user.person.full_name
    nickname = user.person.nickname
    document_number = user.person.document_number
    email = user.email
    roles = I18n.t(user.all_roles, scope: 'activerecord.attributes.user/role.kinds').join(', ')
    enterprise = user.enterprise.company_name
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
    expect(page).to have_no_content(enterprise)
    expect(page).to have_content(is_active)
    expect(button_show).to eql(true)
    expect(button_edit).to eql(true)
    expect(button_delete).to eql(true)
  end

  expect(page).to have_content("#{@user.enterprise.users.count} registros")
end
