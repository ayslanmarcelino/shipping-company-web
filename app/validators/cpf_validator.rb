# frozen_string_literal: true

class CpfValidator < CpfOrCnpjValidator
  private

  def valid?(document)
    CPF.valid?(document)
  end
end
