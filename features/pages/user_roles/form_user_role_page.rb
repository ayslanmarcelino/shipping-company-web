# frozen_string_literal: true

class FormUserRolePage < SitePrism::Page
  element :select_role, '#user_role_kind_cd'
  element :select_enterprise, '#user_role_enterprise_id'
  element :select_user, '#user_role_user_id'
  element :button_edit_user_role, '#update_user_role'
  element :button_create_user_role, '#create_user_role'

  def form_page?
    select_role.present?
    select_enterprise.present?
    select_user.present?
  end

  def edit_page?
    form_page?
    button_edit_user_role.present?
  end

  def new_page?
    form_page?
    button_create_user_role.present?
  end

  def select_roles_owner?
    @roles = %w[Financeiro Monitoramento Operacional Proprietário]
    @roles.each do |role|
      select_role.select(role).present?
    end
  end

  # def select_roles_master?
  #   select_roles_owner?
  #   select_role.select('Master').present?
  # end

  def fill_all_fields(user)
    select_role.select(@roles.first)
    select_enterprise.select(user.enterprise.company_name)
    select_user.select(user.person.full_name)
  end

  def fill_existing_role(role)
    select_role.select(I18n.t(role.kind_cd, scope: 'activerecord.attributes.user/role.kinds'))
    select_enterprise.select(role.enterprise.company_name)
    select_user.select(role.user.person.full_name)
  end

  def fill_existing_role_with_different_user(user, role)
    select_role.select(I18n.t(role.kind_cd, scope: 'activerecord.attributes.user/role.kinds'))
    select_enterprise.select(role.enterprise.company_name)
    select_user.select(user.person.full_name)
  end

  def update_kind_to_operational
    select_role.select('Financeiro')
  end

  def remove_role
    select_role.select('Selecione um tipo de regra')
  end

  def remove_enterprise
    select_enterprise.select('Selecione uma empresa')
  end

  def remove_user
    select_user.select('Selecione um usuário')
  end

  def update_kind_to_existing(user_role)
    select_role.select(I18n.t(user_role.kind_cd, scope: 'activerecord.attributes.user/role.kinds'))
  end

  def click_new_user_role
    button_create_user_role.click
  end

  def click_edit_user_role
    button_edit_user_role.click
  end
end
