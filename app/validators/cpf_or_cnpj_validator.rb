# frozen_string_literal: true

class CpfOrCnpjValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute) unless valid?(value)
  end

  private

  def valid?(document)
    CPF.valid?(document) || CNPJ.valid?(document)
  end
end
