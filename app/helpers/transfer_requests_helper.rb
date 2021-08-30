module TransferRequestsHelper
  def transfer_types_collection
    [
      ['Adiantamento', 'advance'],
      ['Descarga', 'discharge'],
      ['Saldo', 'balance'],
      ['Agenciamento', 'agency'],
      ['Frete todo', 'full'],
      ['Diária', 'daily'],
      ['Outros', 'other']
    ].sort
  end

  def transfer_status_collection
    [
      ['Pendente', 'pending'],
      ['Cancelada', 'canceled'],
      ['Rejeitada', 'rejected'],
      ['Aprovada', 'approved'],
    ].sort
  end
end
