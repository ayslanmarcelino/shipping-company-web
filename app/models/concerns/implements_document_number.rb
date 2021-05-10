# frozen_string_literal: true

module ImplementsDocumentNumber
  def cpf_or_cnpj_column(columns, presence: true, validator: CpfOrCnpjValidator, uniqueness: false)
    columns = [columns] unless columns.respond_to?(:each)
    columns.each do |column|
      validates(column, presence: presence)
      validates(column, uniqueness: uniqueness, allow_blank: true)
      validates_with(validator, attributes: column, if: -> { public_send(column).present? && errors[column].blank? })
      define_document_number_methods(column)
    end
  end

  def cpf_column(column, presence: true)
    validates(column, length: { is: 11 }, allow_blank: true)
    cpf_or_cnpj_column(column, presence: presence, validator: CpfValidator)
  end

  def cnpj_column(column, presence: true)
    validates(column, length: { is: 14 }, allow_blank: true)
    cpf_or_cnpj_column(column, presence: presence, validator: CnpjValidator)
  end

  def normalized_document(value)
    value&.gsub(/\D/, '')
  end

  def formatted_document(document)
    return if (clean = normalized_document(document)).blank?

    case clean.size
    when 11 then "#{clean[0, 3]}.#{clean[3, 3]}.#{clean[6, 3]}-#{clean[9, 2]}"
    when 14 then "#{clean[0, 2]}.#{clean[2, 3]}.#{clean[5, 3]}/#{clean[8, 4]}-#{clean[12, 2]}"
    end
  end

  private

  def define_document_number_methods(column)
    define_attributes_translation("formatted_#{column}": human_attribute_name(column))

    setter = :"#{column}="
    define_method(setter) { |value| super(self.class.normalized_document(value)) }
    alias_method(:"formatted_#{column}=", setter)
    define_method(:"formatted_#{column}") { self.class.formatted_document(public_send(column)) }
    define_method(:"normalized_#{column}") { self.class.normalized_document(public_send(column)) }
    define_method(:"#{column}_type") do
      value = public_send(:"normalized_#{column}")
      if CPF.valid?(value)
        :cpf
      elsif CNPJ.valid?(value)
        :cnpj
      end
    end
    define_singleton_method(:"find_by_#{column}") { |value| find_by(column => normalized_document(value)) }
  end
end
  