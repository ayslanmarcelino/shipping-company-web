# frozen_string_literal: true

class FormUserRolePage < SitePrism::Page
  element :select_role, '#user_role_kind_cd'
  element :select_enterprise, '#user_role_enterprise_id'
  element :select_user, '#user_role_user_id'
  element :button_edit_user_role, '#update_user_role'

  def form_page?
    select_role.present?
    select_enterprise.present?
    select_user.present?
  end

  def edit_page?
    form_page?
    button_edit_user_role.present?
  end
end
