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

  def agent_color(boolean)
    boolean ? 'secondary' : 'success'
  end

  def status_color(status)
    return 'warning' if status == 'pending'
    return 'danger' if status == 'rejected'
    return 'success' if status == 'approved'
    return 'info' if status == 'canceled'
  end

  def money_color(value)
    return '#4f9800' if value.zero?
    return '#c65a56' if value.negative?
    return '#95951b' if value.positive?
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
     ['Operacional', 'operational'],
     ['Financeiro', 'financial']].sort
  end

  def role_select
    [['Proprietário', 'owner'],
     ['Operacional', 'operational'],
     ['Financeiro', 'financial']].sort
  end

  def pix_key_types_select
    [['CPF/CNPJ', 'document_number'],
     ['Celular', 'phone_number'],
     ['E-mail', 'email'],
     ['Chave aleatória', 'random_key']]
  end

  def account_types_select
    [
      ['Conta Poupança', 'saving_account'],
      ['Conta Corrente', 'current_account'],
      ['Conta Salário', 'salary_account'],
      ['Conta Investimento', 'investment_account'],
      ['Conta Conjunta', 'joint_account'],
      ['Conta Pagamento', 'payment_account'],
    ]
  end

  def transfer_types_select
    [
      ['Adiantamento', 'advance'],
      ['Descarga', 'discharge'],
      ['Saldo', 'balance'],
      ['Agenciamento', 'agency'],
      ['Frete todo', 'full'],
      ['Diária', 'daily'],
      ['Outros', 'other']
    ]
  end

  def method_types_select
    [
      ['Pix', 'pix'],
      ['TED', 'ted'],
      ['DOC', 'doc'],
      ['TEV', 'tev'],
      ['Boleto', 'boleto'],
      ['Outros', 'other']
    ]
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
