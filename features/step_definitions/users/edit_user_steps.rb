Então('o sistema deverá redirecionar para a página de edição de usuário') do
  form_user_page = FormUserPage.new

  form_user_page.edit_user_page?
  expect(page).to have_current_path("/admins/users/#{@users.last.id}/edit")
end

Quando('for redirecionado para a tela de editar usuário') do
  expect(page).to have_current_path("/admins/users/#{@users.last.id}/edit")
end

Então('quero visualizar a tela de editar usuário') do
  form_user_page = FormUserPage.new

  form_user_page.edit_user_page?
end
