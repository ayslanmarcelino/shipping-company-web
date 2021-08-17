module ApplicationHelper
  def format_document_number(document_number)
    document_number.length == 11 ? document_number.to_br_cpf : document_number.to_br_cnpj
  end

  def translate_boolean(boolean)
    boolean ? t('application.positive') : t('application.negative')
  end

  def boolean_color(boolean)
    boolean ? 'success' : 'danger'
  end

  def user_master?(current_user)
    current_user.roles.kind_masters.present?
  end

  def user_owner?(current_user)
    current_user.roles.kind_owners.present?
  end

  def role_master_select
    [['Master', 'master'],
     ['Proprietário', 'owner'],
     ['Operacional', 'operational']]
  end

  def role_select
    [['Proprietário', 'owner'],
     ['Operacional', 'operational']]
  end

  def pix_key_types_select
    [['CPF/CNPJ', 'document_number'],
     ['Celular', 'phone_number'],
     ['E-mail', 'email'],
     ['Chave aleatória', 'random_key']]
  end

  def swal_type_from_notification_type(type)
    case type
    when 'success', 'notice' then 'success'
    when 'alert' then 'warning'
    when 'danger', 'error', 'denied' then 'error'
    when 'question' then 'question'
    else 'info'
    end
  end
end
