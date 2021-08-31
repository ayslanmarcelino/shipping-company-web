Então('o sistema deverá redirecionar para a página de edição de regra de usuário') do
  form_user_role_page = FormUserRolePage.new

  form_user_role_page.edit_page?
  expect(page).to have_current_path("/user/roles/#{@user_roles.last.id}/edit")
end
