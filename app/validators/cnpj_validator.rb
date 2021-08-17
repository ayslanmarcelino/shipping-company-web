# frozen_string_literal: true

class CnpjValidator < CpfOrCnpjValidator
  private

  def valid?(document)
    CNPJ.valid?(document)
  end
end
