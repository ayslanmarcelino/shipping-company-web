Quando('preencher todos os dados solicitados para novo usuário') do
  @registered_users_count = User.count
  @new_user_page.fill_all_fields(@user)

  enterprise_options_count
end

Quando('clicar em Criar novo usuário') do
  @new_user_page.click_new_user
end

Quando('preencher apenas dados obrigatórios para novo usuário') do
  @registered_users_count = User.count
  @new_user_page.fill_required_fields(@user)
end

Quando('preencher apenas dados obrigatórios para novo usuário e apenas CEP') do
  @new_user_page.fill_required_fields(@user)
  @new_user_page.fill_address_zip_code
end

Quando('preencher todos os dados solicitados para novo usuário com CPF já cadastrado') do
  @new_user_page.fill_all_fields(@user)
  enterprise_options_count
  @new_user_page.fill_existing_document_number(@user)
end

Quando('preencher todos os dados solicitados para novo usuário com e-mail já cadastrado') do
  @new_user_page.fill_all_fields(@user)
  enterprise_options_count
  @new_user_page.fill_existing_email(@user)
end

private

def enterprise_options_count
  @new_user_page.options_in_select == Enterprise.count + 1 if @user.roles.kind_masters.present?
  @new_user_page.options_in_select == 2 if @user.roles.kind_masters.empty?
end
