Quando('preencher todos os dados solicitados para novo usuário') do
  @new_user_page.fill_all_fields(@user)
end

Quando('clicar em Criar novo usuário') do
  @new_user_page.click_new_user
end
