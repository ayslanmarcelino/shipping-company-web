# frozen_string_literal: true

class UserRolesPage < SitePrism::Page
  element :label_registered_user_roles, 'h4', text: 'Regras de usuários cadastradas'
  element :button_filter, '#filter'
  element :table_user_roles, '#table'
  element :th_id, 'th', text: 'Código'
  element :th_role, 'th', text: 'Regra'
  element :th_user, 'th', text: 'Usuário'
  element :th_created_at, 'th', text: 'Criado em'
  element :button_create_new_user_role, '#create-new-user-role'
  # element :th_enterprise, 'th', text: 'Empresa'

  def owner_user_roles_page?
    label_registered_user_roles.present?
    button_filter.present?
    table_user_roles.present?
    th_id.present?
    th_role.present?
    th_user.present?
    th_created_at.present?
    button_create_new_user_role.present?
  end
end
