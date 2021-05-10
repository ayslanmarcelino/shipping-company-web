class ApplicationRecord < ActiveRecord::Base
  extend ImplementsDocumentNumber
  self.abstract_class = true
end
