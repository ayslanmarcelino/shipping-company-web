Quando('for redirecionado para a tela de novo usuário') do
  form_user_page = FormUserPage.new

  form_user_page.new_user_page?
  expect(page).to have_current_path('/admins/users/new')
end

Quando('preencher todos os dados solicitados para novo usuário') do
  @registered_users_count = User.count
  @form_user_page.fill_all_fields(@user)

  enterprise_options_count
end

Quando('clicar em Criar novo usuário') do
  @form_user_page.click_new_user
end

Quando('preencher apenas dados obrigatórios para novo usuário') do
  @registered_users_count = User.count
  @form_user_page.fill_required_fields(@user)
end

Quando('preencher apenas dados obrigatórios para novo usuário e apenas CEP') do
  @form_user_page.fill_required_fields(@user)
  @form_user_page.fill_address_zip_code
end

Quando('preencher todos os dados solicitados para novo usuário com CPF já cadastrado') do
  @form_user_page.fill_all_fields(@user)
  enterprise_options_count
  @form_user_page.fill_existing_document_number(@user)
end

Quando('preencher todos os dados solicitados para novo usuário com e-mail já cadastrado') do
  @form_user_page.fill_all_fields(@user)
  enterprise_options_count
  @form_user_page.fill_existing_email(@user)
end

private

def enterprise_options_count
  @form_user_page.options_in_select == Enterprise.count + 1 if @user.roles.kind_masters.present?
  @form_user_page.options_in_select == 2 if @user.roles.kind_masters.empty?
end
