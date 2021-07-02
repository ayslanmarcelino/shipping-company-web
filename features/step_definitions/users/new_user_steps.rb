Quando('preencher todos os dados solicitados para novo usuário') do
  @new_user_page.fill_all_fields(@user)

  @new_user_page.options_in_select == Enterprise.count + 1 if @user.roles.kind_masters.present?
  @new_user_page.options_in_select == 2 if @user.roles.kind_masters.empty?
end

Quando('clicar em Criar novo usuário') do
  @new_user_page.click_new_user
end

Quando('preencher apenas dados obrigatórios para novo usuário') do
  @new_user_page.fill_required_fields(@user)
end

Quando('preencher apenas dados obrigatórios para novo usuário e apenas CEP') do
  @new_user_page.fill_required_fields(@user)
  @new_user_page.fill_address_zip_code
end
