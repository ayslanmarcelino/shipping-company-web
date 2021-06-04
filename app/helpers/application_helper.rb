module ApplicationHelper
  def format_document_number(document_number)
    document_number.length == 14 ? document_number.to_br_cpf : document_number.to_br_cnpj
  end

  def translate_boolean(boolean)
    boolean ? t('application.positive') : t('application.negative')
  end

  def function_color(active)
    return 'danger' if !active
  end

  def function_translate(active)
    return t('application.disabled') unless active
  end

  def enterprise_color(is_active)
    is_active ? 'success' : 'danger'
  end

  def enterprise_status(is_active)
    is_active ? t('application.actived') : t('application.disabled')
  end

  def user_master?(current_user)
    current_user.roles.kind_masters.present?
  end
  
  def user_owner?(current_user)
    current_user.roles.kind_owners.present?
  end
end
