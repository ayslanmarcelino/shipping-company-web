class ApplicationRecord < ActiveRecord::Base
  extend ImplementsDocumentNumber
  self.abstract_class = true

  def self.translate_enum(name, value)
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{name.to_s.pluralize}.#{value}")
  end

  def self.define_attributes_translation(attributes)
    hash = { model_name.i18n_key => attributes }
    I18n.backend.store_translations(:'pt-BR', activerecord: { attributes: hash })
  end
end
