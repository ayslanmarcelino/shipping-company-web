# frozen_string_literal: true

class UsersPage < SitePrism::Page
  element :label_registered_users, 'h4', text: 'Usuários cadastrados'
  element :button_filter, '#filter'
  element :table_users, '.card-body'
  element :table_length, '#table_length'
  element :table_filter, '#table_filter'
  element :th_id, 'th', text: 'Código'
  element :th_full_name, 'th', text: 'Nome completo'
  element :th_nickname, 'th', text: 'Apelido'
  element :th_document_number, 'th', text: 'CPF/CNPJ'
  element :th_email, 'th', text: 'E-mail'
  element :th_roles, 'th', text: 'Regra(s) de usuário'
  element :th_is_active, 'th', text: 'Ativo?'
  element :th_enterprise, 'th', text: 'Empresa'
  element :button_new_user, 'a[href="/admins/users/new"]'

  def owner_table?
    table_users.present?
    table_length.present?
    table_filter.present?
    th_id.present?
    th_full_name.present?
    th_nickname.present?
    th_document_number.present?
    th_email.present?
    th_roles.present?
    th_is_active.present?
    button_new_user.present?
  end

  def master_table?
    owner_table?
    th_enterprise.present?
  end

  def owner_users_page?
    label_registered_users.present?
    button_filter.present?
    owner_table?
  end

  def master_users_page?
    master_table?
    owner_users_page?
  end

  def click_new_user
    button_new_user.click
  end
end
