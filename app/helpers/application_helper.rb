module ApplicationHelper
  def format_document_number(document_number)
    document_number.length == 14 ? document_number.to_br_cpf : document_number.to_br_cnpj
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
end
