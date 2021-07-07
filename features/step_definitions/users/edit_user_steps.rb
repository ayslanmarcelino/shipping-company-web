Então('o sistema deverá redirecionar para a página de edição de usuário') do
  form_user_page = FormUserPage.new

  form_user_page.update_user_page?
  expect(page).to have_current_path("/admins/users/#{@users.last.id}/edit")
end
