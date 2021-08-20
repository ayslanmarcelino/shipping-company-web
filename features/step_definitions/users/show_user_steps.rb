Quando('for redirecionado para a tela de detalhes do usuário') do
  @show_user_page = ShowUserPage.new

  @show_user_page.show_user_page?
  expect(page).to have_current_path("/admins/users/#{@users.last.id}")
end

Então('o sistema deve retornar todos os dados do usuário') do
  user = @users.last

  @show_user_page.nav_personal?
  expect(page).to have_content(user.person.full_name)
  expect(page).to have_content(user.person.nickname)
  expect(page).to have_content(user.email)
  expect(page).to have_content(I18n.l(user.person.birth_date, format: :date))
  expect(page).to have_content(user.person.phone_number)
  expect(page).to have_content(user.person.telephone_number)

  @show_user_page.click_nav_document
  @show_user_page.nav_document?
  expect(page).to have_content(user.person.document_number.to_br_cpf)
  expect(page).to have_content(user.person.rg)
  expect(page).to have_content(user.person.rg_issuing_body)

  @show_user_page.click_nav_address
  @show_user_page.nav_address?
  expect(page).to have_content(user.person.address.zip_code)
  expect(page).to have_content(user.person.address.street)
  expect(page).to have_content(user.person.address.number)
  expect(page).to have_content(user.person.address.complement) if user.person.address.complement.present?
  expect(page).to have_content(user.person.address.neighborhood)
  expect(page).to have_content(user.person.address.city)
  expect(page).to have_content(user.person.address.state)
  expect(page).to have_content(user.person.address.country)
end
