module ApplicationHelper
  def format_document_number(document_number)
    document_number.length == 11 ? document_number.to_br_cpf : document_number.to_br_cnpj
  end

  def translate_boolean(boolean)
    boolean ? t('application.positive') : t('application.negative')
  end

  def function_color(active, admin, super_admin)
    return 'danger' if !active
    return 'success' if active && super_admin
    return 'info' if active && admin
    return 'secondary' if active && !admin
  end

  def function_translate(active, admin, super_admin)
    return t('application.disabled') unless active
    return t('application.super_admin') if active && super_admin
    return t('application.admin') if active && admin
    return t('application.employee') if active && !admin && !super_admin
  end

  def enterprise_color(is_active)
    is_active ? 'success' : 'danger'
  end

  def enterprise_status(is_active)
    is_active ? t('application.actived') : t('application.disabled')
  end
end
