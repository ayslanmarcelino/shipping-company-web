Quando('clicar no menu Usuários') do
  @users_page = UsersPage.new

  @menu_page.click_users
end

Quando('clicar no menu Regras de usuário') do
  @user_roles_page = UserRolesPage.new

  @menu_page.click_user_roles
end
