Quando('clicar no menu Usuários') do
  @users_page = UsersPage.new

  @menu_page.click_users
end
