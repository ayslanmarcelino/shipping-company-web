# == Schema Information
#
# Table name: enterprises
#
#  id              :bigint           not null, primary key
#  company_name    :string           not null
#  document_number :string           not null
#  email           :string           not null
#  fantasy_name    :string           not null
#  is_active       :boolean          default(TRUE), not null
#  opening_date    :date             not null
#  primary_color   :string           not null
#  secondary_color :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_enterprises_on_document_number  (document_number) UNIQUE
#
class Enterprise < ApplicationRecord
  has_many :users
  has_one_attached :logo
  validates_uniqueness_of :document_number
  validates_presence_of %i[company_name fantasy_name document_number email opening_date primary_color secondary_color]
end
