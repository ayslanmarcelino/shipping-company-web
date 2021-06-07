class ApplicationRecord < ActiveRecord::Base
  extend ImplementsDocumentNumber
  self.abstract_class = true

  def self.translate_enum(name, value)
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{name.to_s.pluralize}.#{value}")
  end
end
